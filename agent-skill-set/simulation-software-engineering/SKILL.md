---
name: simulation-software-engineering
description: |
 Strict software engineering and architecture skill for designing, developing, reviewing, refactoring, and maintaining high-quality simulation and computational software. Language-independent and simulation-domain-independent. Emphasizes architectural integrity, maintainability, testability, reproducibility, and measurable software quality.
---

Simulation Software Engineering
1. Mission

This skill defines mandatory engineering principles and architectural rules for building high-quality simulation software.

The objective is to create software systems that remain understandable, maintainable, extensible, testable, and reliable throughout their lifecycle.

The agent MUST prioritize:

Architectural clarity.
Separation of concerns.
High cohesion and low coupling.
Explicit dependency management.
Strong encapsulation.
Testability and verifiability.
Reproducibility.
Controlled extensibility.
Measurable quality.
Long-term maintainability.

This skill applies to:

New software development.
Existing codebase development.
Architectural redesign.
Refactoring.
Feature additions.
Performance optimization.
Integration of external components.
Software maintenance.

The skill is independent of programming language, numerical method, physical model, and simulation domain.

The agent MUST apply these rules to both new and existing software.

2. Engineering Philosophy
2.1 Clarity First

Clarity is the primary architectural objective.

Every component MUST have an identifiable purpose and responsibility.

Code MUST communicate its intent through its structure, naming, interfaces, and data flow.

Prefer explicit behavior over hidden conventions.

Avoid clever implementations that make the system difficult to understand.

2.2 Architectural Integrity

Architecture is not merely a directory structure.

It consists of:

Component responsibilities.
Dependency relationships.
Interface contracts.
Data ownership.
State transitions.
Execution boundaries.
Architectural constraints.

These elements MUST remain consistent as the system evolves.

Architectural boundaries MUST be reflected in implementation, not merely described in documentation.

2.3 Separation of Concerns

Different responsibilities MUST be separated.

In simulation software, distinguish at least:

Domain concepts.
Simulation state.
Computational models.
Numerical algorithms.
Execution control.
Configuration.
Data persistence.
Visualization.
External infrastructure.

Do not combine unrelated responsibilities for implementation convenience.

2.4 High Cohesion and Low Coupling

Each module SHOULD contain functionality belonging to one coherent responsibility.

Dependencies MUST be explicit and minimized.

Changes to one component SHOULD have limited impact on unrelated components.

2.5 Controlled Abstraction

Abstraction MUST solve a real architectural problem.

Introduce abstractions when they:

Establish meaningful boundaries.
Protect important invariants.
Reduce coupling.
Enable legitimate substitution.
Improve independent testing.
Support required extensibility.

Do not introduce abstractions solely to make the design appear sophisticated.

2.6 Long-Term Maintainability

Optimize for the cost of understanding, changing, testing, and extending the software over time.

Short-term implementation convenience MUST NOT justify unnecessary architectural degradation.

3. Quality Model: ISO/IEC 25010

Use ISO/IEC 25010:2023 as a reference framework for software product quality.

The agent MUST consider quality as a collection of distinct characteristics rather than treating code cleanliness as the only measure.

Evaluate the following areas:

3.1 Functional Suitability

The software MUST provide the required functionality correctly and completely.

3.2 Performance Efficiency

Computational and memory resources MUST be used appropriately.

Performance requirements SHOULD be measurable.

3.3 Compatibility

Components MUST interact through well-defined contracts.

External integrations and data exchange MUST have explicit compatibility expectations.

3.4 Interaction Capability

Interfaces and workflows SHOULD make system behavior understandable and predictable to their intended users.

3.5 Reliability

The software MUST handle failures, unexpected conditions, and resource limitations appropriately.

3.6 Security

External inputs, dependencies, data handling, and execution environments MUST be considered.

3.7 Maintainability

The architecture MUST support:

Modularity.
Reusability where justified.
Analysability.
Modifiability.
Testability.
3.8 Flexibility

The system SHOULD accommodate legitimate changes in configuration, deployment, computational methods, and execution environments without unnecessary restructuring.

3.9 Safety

Where incorrect behavior can cause physical, financial, scientific, or operational harm, safety-related requirements MUST be explicitly identified and verified.

3.10 Quality Requirements Must Be Verifiable

Do not use vague statements such as:

The system should be highly maintainable.
The architecture should be flexible.
The implementation should be fast.
The software should be robust.

Translate important quality requirements into observable scenarios.

Example:

Requirement: A new solver implementation can be introduced without modifying existing domain models.

Verification: Introduce a second solver implementation and verify that existing model components remain unchanged.

Example:

Requirement: Changing the output storage format must not affect computational algorithms.

Verification: Replace the persistence adapter and execute the same computational test suite.

4. Mandatory Software Engineering Principles
4.1 SOLID

All five SOLID principles MUST be considered.

Single Responsibility Principle

Each component MUST have one coherent responsibility and one primary reason to change.

Open-Closed Principle

Stable components SHOULD be extensible without unnecessary modification.

Liskov Substitution Principle

Implementations MUST preserve the behavioral contract of their abstractions.

Interface Segregation Principle

Interfaces MUST expose only related operations.

Dependency Inversion Principle

High-level policies MUST depend on abstractions rather than concrete infrastructure implementations.

4.2 DRY

Avoid duplicated knowledge and business rules.

Do not merge distinct responsibilities merely because their current implementations look similar.

4.3 KISS

Prefer the simplest design that satisfies requirements and architectural constraints.

4.4 YAGNI

Do not implement hypothetical features without a credible requirement.

4.5 Composition over Inheritance

Prefer composition unless a genuine behavioral subtype relationship exists.

4.6 Encapsulation

Hide internal implementation details.

Expose only meaningful public interfaces.

4.7 Principle of Least Knowledge

Components SHOULD interact through narrow interfaces rather than navigating unrelated internal object structures.

4.8 Explicit Dependencies

Dependencies MUST be visible and understandable.

Avoid hidden dependencies through global registries, unrestricted singletons, and implicit shared state.

5. Architecture and Layering
5.1 Recommended Architectural Style

Use Clean Architecture or Hexagonal Architecture principles as a foundation.

Do not force every project into an identical directory structure.

The architecture MUST preserve the following conceptual boundaries:

Domain

Contains:

Domain entities.
Value objects.
Domain invariants.
Domain concepts.
Domain rules.

MUST NOT depend on presentation or infrastructure implementations.

Computational Core

Contains:

Computational models.
Numerical algorithms.
Calculation strategies.
State transformations.
Computational interfaces.

MUST remain independent of UI and persistence implementations.

Application

Contains:

Use cases.
Simulation lifecycle orchestration.
Execution coordination.
Configuration workflows.
Application-level validation.

Coordinates domain and computational components without absorbing their responsibilities.

Infrastructure

Contains:

File systems.
Databases.
Serialization.
External libraries.
Hardware-specific implementations.
Logging infrastructure.
External services.
Presentation

Contains:

UI.
Visualization.
CLI.
External APIs.
Result presentation.

MUST NOT contain computational domain rules.

5.2 Dependency Rules

Dependencies MUST point toward stable policies and abstractions.

Prohibited dependencies include:

Domain -> Presentation.
Domain -> Infrastructure.
Computational Core -> Presentation.
Computational Core -> Specific persistence implementations.

Avoid circular dependencies.

5.3 Module Organization

Organize code around cohesive responsibilities and meaningful boundaries.

Avoid indiscriminate collections of:

Helpers.
Utilities.
Common modules.
Managers.
Services.

A module MUST have a clear ownership and responsibility.

5.4 Architectural Boundaries Must Be Enforceable

Where practical, use:

Package dependency restrictions.
Module visibility controls.
Interface boundaries.
Static analysis.
Automated architecture tests.
Build-system dependency constraints.

Do not rely exclusively on developer discipline.

6. Simulation-Specific Architecture
6.1 State and Computation Separation

Simulation state MUST be explicitly represented.

Computational algorithms MUST be separated from state storage and execution control.

Conceptually:

Configuration
      |
      v
Simulation Model
      |
      v
Solver + Current State
      |
      v
Updated State
      |
      v
Execution Controller


This is a conceptual responsibility model, not a mandatory implementation sequence.

6.2 State Ownership

Clearly identify ownership of:

Domain state.
Numerical working state.
Execution state.
Configuration state.
Output state.
Diagnostic state.

Avoid uncontrolled shared mutable state.

Use immutable snapshots or controlled state transitions where practical.

6.3 Computational Models

Models MUST describe computational or domain behavior.

They SHOULD NOT directly manage:

File operations.
UI rendering.
Output directories.
Application lifecycle.
Infrastructure configuration.
6.4 Solver Architecture

Solvers MUST encapsulate their computational algorithms.

Use replaceable interfaces when alternative algorithms are genuinely required.

Do not force incompatible algorithms into a single oversized abstraction.

6.5 Simulation Engine

The execution engine SHOULD coordinate:

Initialization.
Iteration.
Time progression.
Convergence monitoring.
Termination.
Pause and resume.
Checkpoint coordination.
Execution status.

The engine MUST NOT become a container for every computational algorithm.

6.6 Time and Iteration Management

Time progression and iteration control SHOULD be explicit.

Consider:

Fixed timesteps.
Variable timesteps.
Iteration limits.
Convergence criteria.
Event-based termination.
Cancellation.
Failure and recovery.

Avoid duplicating execution-control logic across individual solvers.

6.7 Configuration Management

Separate:

User configuration.
Model parameters.
Solver parameters.
Runtime settings.

Configuration MUST be validated before execution.

Important default values MUST be explicit and documented.

6.8 Checkpoint and Restart

When required, checkpointing MUST be designed as a first-class capability.

Define:

What state is persistent.
What state is temporary.
Which components own restoration.
How configuration compatibility is checked.
How incomplete checkpoints are handled.

Test restart behavior independently.

6.9 Reproducibility

Record relevant execution information:

Input data.
Initial conditions.
Configuration.
Algorithm selection.
Random seeds.
Software version.
Dependency versions.
Relevant hardware and execution settings.

Distinguish bitwise reproducibility from numerical equivalence within defined tolerances.

When deterministic execution is impossible, document the limitations.

7. Interface and Component Design
7.1 Component Contracts

Each important component SHOULD define:

Responsibility.
Public interface.
Preconditions.
Postconditions.
Invariants.
Dependencies.
Error behavior.
State ownership.
Lifecycle.
7.2 Interface Design

Interfaces MUST be:

Narrow.
Cohesive.
Explicit.
Stable where appropriate.
Independent of implementation details.

Avoid interfaces with unrelated operations.

7.3 Function Design

Functions SHOULD:

Perform one coherent operation.
Have explicit inputs and outputs.
Minimize side effects.
Avoid hidden state.
Handle failures explicitly.
7.4 Class Design

Classes SHOULD represent meaningful concepts or responsibilities.

Avoid:

God Objects.
Deep inheritance hierarchies.
Excessive accessors.
Unrelated dependencies.
Classes that merely forward calls.
7.5 Naming

Names MUST communicate intent and responsibility.

Avoid ambiguous names unless the surrounding context makes their meaning explicit.

8. Data Architecture
8.1 Data Ownership

Every important mutable data structure MUST have an identifiable owner.

Shared mutable state MUST have explicit synchronization and ownership rules.

8.2 Data Flow

Data flow SHOULD be explicit and traceable.

Avoid hidden communication through global variables and implicit caches.

8.3 Serialization

Serialization MUST be separated from domain and computational logic.

Persistent data formats SHOULD have versioning and compatibility policies.

8.4 Data Validation

Perform validation at appropriate boundaries.

Distinguish:

Input validation.
Configuration validation.
Domain invariant validation.
Computational precondition validation.
Output validation.
8.5 Data Integrity

Important simulation results SHOULD preserve sufficient metadata to identify their origin and execution conditions.

Partial or invalid results MUST NOT be represented as successful completed results.

9. Architecture Documentation

Use the C4 Model as a recommended framework for architecture visualization.

Documentation MUST be proportional to system complexity.

9.1 System Context

Describe:

System boundaries.
External actors.
External systems.
Important interactions.
9.2 Container View

Describe:

Major applications.
Execution processes.
Data stores.
Infrastructure boundaries.
Communication paths.
9.3 Component View

Describe:

Major modules.
Component responsibilities.
Dependencies.
Interface relationships.
9.4 Dynamic View

Where execution complexity warrants it, describe important workflows.

For simulation software, useful workflows include:

Initialization.
Main execution loop.
State updates.
Checkpoint creation.
Restart.
Failure handling.
9.5 Deployment View

When deployment characteristics affect architecture, describe:

Execution environments.
Hardware boundaries.
Distributed components.
External dependencies.
Resource allocation.
9.6 Documentation Rules

Diagrams MUST reflect actual implementation.

Do not create diagrams that are never maintained.

Use the minimum number of views necessary to communicate the architecture accurately.

10. Quality Attribute Scenarios

Following the Software Engineering Institute's architecture evaluation approach, important quality requirements MUST be expressed as scenarios.

A scenario SHOULD specify:

Stimulus.
Context.
Expected response.
Verification criteria.

Examples:

Modifiability

Stimulus: A new solver is required.

Expected response: The new solver can be integrated without changing unrelated domain models.

Verification: Existing solver implementations and domain tests remain unchanged and pass.

Testability

Stimulus: A computational component must be tested independently.

Expected response: The component can be instantiated with controlled dependencies and test data.

Verification: The component can be tested without launching the UI or initializing external infrastructure.

Performance

Stimulus: The simulation workload increases significantly.

Expected response: Performance bottlenecks can be identified and optimized without restructuring unrelated modules.

Verification: Profiling identifies the computational hotspot independently.

Reliability

Stimulus: A computational operation fails.

Expected response: The execution controller reports the failure and prevents incomplete results from being marked as successful.

Verification: Failure injection tests verify the expected execution state.

Reproducibility

Stimulus: A previously executed simulation must be reproduced.

Expected response: The recorded configuration and relevant environment information are sufficient to reconstruct the execution conditions.

Verification: A reproducibility test compares results using explicitly defined equivalence criteria.

11. Architecture Evaluation

The agent MUST evaluate architecture against actual quality requirements.

Do not assume that adopting Clean Architecture or SOLID automatically produces a good architecture.

11.1 Evaluate Change Impact

For important modifications, identify:

Affected components.
Required interface changes.
Dependency changes.
Data ownership changes.
Test impact.
Compatibility impact.
11.2 Evaluate Coupling

Look for:

Circular dependencies.
Excessive dependency chains.
Cross-layer dependencies.
Shared mutable state.
Unnecessary concrete dependencies.
11.3 Evaluate Cohesion

Ask:

Do all responsibilities belong together?
Does the module have one coherent purpose?
Are unrelated changes affecting the same component?
Is the component too large?
11.4 Evaluate Extensibility

Ask:

Can required alternatives be introduced without modifying stable components?
Are interfaces appropriately scoped?
Is extensibility genuinely required?
Has unnecessary generalization been introduced?
11.5 Evaluate Complexity

Ask:

Is every abstraction justified?
Can layers be removed without losing meaningful separation?
Are there unnecessary indirections?
Can the design be understood without extensive documentation?
11.6 Architecture Risk Assessment

For substantial architectural changes, document:

Architectural assumptions.
Potential failure modes.
Quality attribute trade-offs.
Dependencies on external systems.
Unresolved technical risks.

Do not hide trade-offs behind claims that an architecture is universally superior.

12. Requirements and Traceability

Adopt NASA Software Engineering Handbook practices for requirements quality and verification.

12.1 Requirement Quality

Important requirements MUST be:

Clear.
Unambiguous.
Consistent.
Complete enough for implementation.
Individually verifiable.
Traceable to their purpose.
12.2 Traceability

For substantial features, maintain traceability between:

Requirement
    |
    v
Design Decision
    |
    v
Component
    |
    v
Implementation
    |
    v
Test


Not every minor code change requires a formal traceability document.

However, important functional, architectural, and quality requirements MUST have identifiable verification methods.

12.3 Design Consistency

The implementation MUST remain consistent with the approved architecture.

When implementation constraints require deviation, record the reason and consequences.

13. Testing and Verification

Testing MUST be considered during architecture design.

13.1 Unit Testing

Test individual components independently.

Cover:

Normal behavior.
Boundary conditions.
Invalid inputs.
Invariants.
Failure behavior.
13.2 Integration Testing

Test interactions between architectural boundaries.

13.3 Contract Testing

Verify that implementations satisfy declared interface contracts.

13.4 Simulation-Specific Testing

Where applicable, include:

Reference case tests.
Regression tests.
Conservation and invariant tests.
Convergence tests.
Numerical stability tests.
Determinism tests.
Restart consistency tests.
Long-running execution tests.
13.5 Characterization Testing

For legacy systems with insufficient documentation or test coverage, capture important existing behavior before refactoring.

Do not assume undocumented behavior can be safely removed.

13.6 Continuous Integration

Automate appropriate quality checks:

Build.
Unit tests.
Integration tests.
Static analysis.
Formatting.
Dependency checks.
Architecture tests.
Regression tests.

The CI pipeline SHOULD provide rapid feedback.

14. Performance Engineering
14.1 Measure Before Optimizing

Optimization MUST be evidence-based.

Follow:

Establish requirements.
Measure baseline performance.
Profile.
Identify bottlenecks.
Evaluate alternatives.
Implement.
Measure again.
Verify correctness.
14.2 Isolate Computational Hotspots

Computationally expensive operations SHOULD be identifiable and independently optimizable.

14.3 Memory Management

Explicitly consider:

Allocation frequency.
Memory ownership.
Data lifetime.
Copying overhead.
Cache locality.
Temporary buffers.
Memory growth.
14.4 Parallelization

Define:

Independent tasks.
Shared state.
Synchronization.
Data ownership.
Failure propagation.
Reproducibility constraints.
14.5 Performance Exceptions

If performance requires bypassing an abstraction, document:

The measured bottleneck.
The reason for the exception.
The affected architectural boundary.
The correctness guarantees.
The maintenance implications.

Keep performance-specific exceptions localized.

15. Security and Dependency Management

Adopt relevant practices from NIST SP 800-218 (SSDF).

15.1 Dependency Management

External dependencies MUST be:

Explicitly declared.
Version controlled or constrained.
Evaluated for suitability.
Updated through a controlled process.

Avoid unnecessary dependencies.

15.2 Input and File Safety

Treat external files, datasets, configurations, and serialized objects as untrusted input.

Validate inputs before they enter sensitive computational or persistence components.

15.3 Supply Chain

Where practical:

Track dependency versions.
Review dependency origins.
Monitor known vulnerabilities.
Preserve software provenance.
Use reproducible build practices.
15.4 Secrets and Credentials

Never hardcode credentials or sensitive configuration in source code.

16. Scientific Software Sustainability

Simulation software often supports research and long-lived computational workflows.

Therefore, sustainability MUST be considered as an engineering concern.

16.1 Version Control

Use version control for all important source code and configuration changes.

Important releases SHOULD be identifiable and reproducible.

16.2 Computational Provenance

Preserve relevant information about:

Source revision.
Input datasets.
Parameters.
Execution environment.
Dependency versions.
Algorithm configuration.
16.3 Documentation

Document:

Installation.
Configuration.
Execution.
Testing.
Architecture.
Known limitations.
Reproduction procedures.
16.4 Automated Testing

Use automated tests to prevent unnoticed regressions.

16.5 Release Management

Important releases SHOULD have:

Version identifiers.
Release notes.
Known limitations.
Dependency information.
Reproduction information.
17. Error Handling
17.1 Explicit Failure Semantics

Errors MUST NOT be silently ignored.

17.2 Error Classification

Distinguish:

Invalid input.
Configuration errors.
Domain violations.
Numerical failures.
Convergence failures.
Resource exhaustion.
Infrastructure failures.
Programming errors.
17.3 Error Propagation

Handle errors at the appropriate architectural layer.

Catch errors only when meaningful handling is possible.

17.4 Simulation Execution Status

Represent execution states explicitly.

Examples:

NotStarted.
Initializing.
Running.
Paused.
Completed.
Failed.
Cancelled.

The exact state model SHOULD reflect actual lifecycle requirements.

Incomplete results MUST be distinguishable from successful results.

18. Refactoring Existing Software

Refactoring MUST preserve existing observable behavior unless an intentional change is approved.

18.1 Understand First

Before restructuring:

Inspect the architecture.
Identify dependencies.
Identify consumers.
Understand state ownership.
Inspect existing tests.
Identify compatibility constraints.
18.2 Establish a Baseline

Run existing tests and record known behavior.

When test coverage is inadequate, add characterization tests for important behavior.

18.3 Refactor Incrementally

Prefer:

Identify a responsibility violation.
Define the intended boundary.
Extract the responsibility.
Redirect dependencies.
Verify behavior.
Remove obsolete code.
Update documentation.
18.4 Avoid Unnecessary Rewrites

A full rewrite MUST NOT be the default response to poor architecture.

Explain why incremental refactoring is insufficient before recommending a rewrite.

18.5 Manage Technical Debt

Document:

Existing architectural problems.
Risks.
Impact.
Proposed remediation.
Priority.

Do not introduce undocumented permanent workarounds.

19. Architecture Decision Records

Important architectural decisions SHOULD be recorded as ADRs.

Each ADR SHOULD contain:

Title.
Context.
Problem.
Alternatives.
Decision.
Rationale.
Consequences.
Trade-offs.

Use ADRs for significant decisions such as:

Architectural style.
Module boundaries.
State ownership.
Solver abstraction.
Persistence strategy.
Parallel execution.
External dependencies.
Public interface changes.

Keep records concise and focused.

20. AI Agent Development Protocol

The agent MUST follow this protocol.

20.1 Before Coding
Understand the requirement.
Inspect the affected code.
Identify architectural boundaries.
Identify dependencies.
Identify state ownership.
Identify potential risks.
Determine the verification strategy.
20.2 During Design
Assign each responsibility to the correct component.
Define necessary interfaces.
Determine dependency direction.
Identify state transitions.
Consider failure behavior.
Consider testability.
Evaluate architectural trade-offs.
20.3 During Implementation
Follow established architecture.
Keep changes focused.
Avoid unnecessary abstractions.
Preserve encapsulation.
Avoid hidden dependencies.
Avoid global mutable state.
Add appropriate tests.
Update relevant documentation.
20.4 After Implementation
Run relevant tests.
Run static analysis.
Review dependency changes.
Check architectural boundaries.
Check compatibility.
Review performance implications.
Review documentation.
Report remaining risks.
20.5 Challenge Bad Designs

The agent MUST NOT blindly implement changes that substantially violate architectural principles.

When a request would degrade architecture:

Explain the architectural problem.
Identify the affected principles.
Propose a better alternative.
Explain the trade-offs.
Ask for clarification when necessary.
20.6 Avoid Overengineering

Strict architectural principles do not justify unnecessary complexity.

Every layer, interface, abstraction, and design pattern MUST have a meaningful purpose.

20.7 Honest Verification

The agent MUST distinguish:

Verified behavior.
Assumed behavior.
Untested behavior.
Known limitations.

Never claim that tests, benchmarks, or architectural checks succeeded without executing them.

21. Mandatory Architectural Review Checklist

For every substantial change, evaluate the following.

Responsibility
Every component has a clear responsibility.
Responsibilities are cohesive.
Unrelated concerns are separated.
State ownership is explicit.
Dependencies
Dependencies are explicit.
Dependency direction is appropriate.
No circular dependencies exist.
Interfaces are narrow.
Implementation details are encapsulated.
Simulation Architecture
State and computation are separated.
Models and solvers have clear responsibilities.
Execution control is separated from numerical algorithms.
Configuration is explicit.
Failure states are represented.
Reproducibility is considered.
Checkpointing is addressed where required.
Quality
Requirements are verifiable.
Components are testable.
Relevant regression tests exist.
Error handling is explicit.
Documentation is accurate.
Quality attributes have been considered.
Maintainability
No unnecessary abstraction exists.
No God Objects have been introduced.
Changes are localized.
Technical debt is identified.
Compatibility is preserved or intentionally migrated.
Performance and Security
Performance requirements are considered.
Optimization is measurement-based.
Memory ownership is clear.
External inputs are validated.
Dependencies are managed.

Non-applicable items MUST be identified as not applicable rather than implemented unnecessarily.

22. Definition of Done

A task is complete only when:

Requirements are satisfied.
Implementation follows architectural principles.
Responsibilities remain clear.
Dependencies remain controlled.
Relevant tests have been executed.
Existing behavior is preserved or intentionally changed.
Error handling is appropriate.
Documentation is updated.
Architectural deviations are justified.
Known risks are reported.

If any condition remains unsatisfied, explicitly report it.

23. Final Engineering Principles

The following rules summarize the entire skill.

Clarity over cleverness.
Explicitness over hidden behavior.
High cohesion over convenience.
Low coupling over unrestricted access.
Composition over unnecessary inheritance.
Stable abstractions over concrete dependencies.
Separation of state, computation, and execution control.
Testability as an architectural requirement.
Measurable quality over subjective claims.
Requirements traceability over undocumented assumptions.
Measured optimization over speculative optimization.
Incremental refactoring over unnecessary rewrites.
Reproducibility over undocumented execution conditions.
Meaningful abstraction over architectural decoration.
Long-term maintainability over short-term convenience.

The purpose of architecture is not to maximize the number of layers, interfaces, classes, or design patterns.

The purpose is to minimize unnecessary complexity while preserving the ability to understand, verify, change, and extend the system.

A well-designed simulation system makes computational complexity manageable through architectural simplicity and engineering discipline.
