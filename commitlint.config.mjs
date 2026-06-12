import { execSync } from 'node:child_process';

export default {
    rules: {
        // Scope is REQUIRED
        'scope-empty': [2, 'never'],
        'scope-case': [2, 'always', 'kebab-case'],

        // Type validation
        'type-case': [2, 'always', 'lower-case'],
        'type-empty': [2, 'never'],
        'type-enum': [
            2,
            'always',
            [
                'feat', // New feature
                'fix', // Bug fix
                'docs', // Documentation only
                'style', // Formatting, missing semi colons, etc
                'refactor', // Code change that neither fixes a bug nor adds a feature
                'perf', // Performance improvement
                'test', // Adding tests
                'chore', // Maintenance
                'ci', // CI/CD changes
                'build', // Build system changes
                'revert', // Revert a previous commit
            ],
        ],

        // Subject validation
        'subject-case': [1, 'always', 'lower-case'],
        'subject-empty': [2, 'never'],
        'subject-full-stop': [2, 'never', '.'],
        'subject-max-length': [2, 'always', 120],

        // Body validation
        'body-leading-blank': [1, 'always'],
        'body-max-line-length': [2, 'always', 120],

        // Footer validation
        'footer-leading-blank': [1, 'always'],

        // Branch naming validation (custom rule)
        'branch-name-format': [2, 'always'],
    },
    plugins: [
        {
            rules: {
                'branch-name-format': (parsed, when = 'always', value = {}) => {
                    let branchName;

                    try {
                        branchName = execSync('git symbolic-ref --short HEAD', {
                            encoding: 'utf8',
                        }).trim();
                    } catch (error) {
                        return [true];
                    }

                    if (branchName === 'main' || branchName === 'master') {
                        return [true];
                    }

                    const branchPattern =
                        /^(feature|fix|docs|style|refactor|perf|test|chore|ci|build|revert)\/[0-9]{4,}-[a-z0-9-]+$/;
                    const isValid = branchPattern.test(branchName);

                    if (!isValid) {
                        return [
                            false,
                            `❌ Invalid branch name: "${branchName}"

Expected format: <type>/<issue-number>-<short-description>

Rules:
  • Type: feature, fix, docs, style, refactor, perf, test, chore, ci, build, revert
  • Issue number: REQUIRED, minimum 4 digits (e.g., 0001, 0042, 1234)
  • Description: kebab-case (lowercase, words separated by hyphens)

✅ Valid examples:
  • feature/0001-architect-agent
  • fix/0042-database-connection
  • docs/0099-api-documentation
  • feature/1234-workflow-integration

❌ Invalid examples:
  • feature/my-feature (missing issue number)
  • feature/1-bug-fix (issue number < 4 digits)

⚠️  If you don't have an issue yet, create one first!
See: docs/guides/git-workflow.md`,
                        ];
                    }

                    return [true];
                },
            },
        },
    ],
};
