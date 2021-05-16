Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F86BC43616
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 10:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F0936121E
	for <rcu@archiver.kernel.org>; Sun, 16 May 2021 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhEPKUJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 May 2021 06:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231492AbhEPKTx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 May 2021 06:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE25B61370;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160318;
        bh=+qbxKB/sz14YOzVxtErw3U5tza6HXjT/Bf+J89XCxR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvTIGWNBtrK15760P44XVVL0xmMn+CUWYMDnPhy4ps+5bgQapIFvDAlL0cPe8DCV+
         LsNArVxfgYv/t/le46VC16ORbAHzpzyCfI0QAOKLkQ8ywdCv3H10rlh4vetXeDxxpk
         /dEn/mchhz60Bs3XXTHpne/KkeebP+v6V6lHTVKZkF9tYcxf5F3kHdXgXxrsuDc9z6
         m0c+RkQ+mDlT5jCJyC1676aJtpI2KUaYLxRoXjh+nnnzavKYdlHerdgYHyfMliL2yc
         I+UZwqwrpurBOXuqvRhiYn04Nf1WgYK8LLQlWKmohm2IW4kWYZnUoDWUT+L69hdeB8
         jATKs/MDVuseQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o9A-Q7; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Takashi Iwai <tiwai@suse.de>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: [PATCH v3 16/16] docs: RCU: replace some characters
Date:   Sun, 16 May 2021 12:18:33 +0200
Message-Id: <909f3108e85895828bf3633f183e8f364cb4d752.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+00a0 (' '): NO-BREAK SPACE
	  as it can cause lines being truncated on PDF output

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../Data-Structures/Data-Structures.rst       | 46 ++++++------
 .../Expedited-Grace-Periods.rst               | 36 +++++-----
 .../Tree-RCU-Memory-Ordering.rst              |  2 +-
 .../RCU/Design/Requirements/Requirements.rst  | 70 +++++++++----------
 4 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
index f4efd6897b09..b6b4d4bc2402 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.rst
@@ -456,21 +456,21 @@ expedited grace periods, respectively.
 | Lockless grace-period computation! Such a tantalizing possibility!    |
 | But consider the following sequence of events:                        |
 |                                                                       |
-| #. CPU 0 has been in dyntick-idle mode for quite some time. When it   |
+| #. CPU 0 has been in dyntick-idle mode for quite some time. When it   |
 |    wakes up, it notices that the current RCU grace period needs it to |
 |    report in, so it sets a flag where the scheduling clock interrupt  |
 |    will find it.                                                      |
-| #. Meanwhile, CPU 1 is running ``force_quiescent_state()``, and       |
-|    notices that CPU 0 has been in dyntick idle mode, which qualifies  |
+| #. Meanwhile, CPU 1 is running ``force_quiescent_state()``, and       |
+|    notices that CPU 0 has been in dyntick idle mode, which qualifies  |
 |    as an extended quiescent state.                                    |
-| #. CPU 0's scheduling clock interrupt fires in the middle of an RCU   |
+| #. CPU 0's scheduling clock interrupt fires in the middle of an RCU   |
 |    read-side critical section, and notices that the RCU core needs    |
 |    something, so commences RCU softirq processing.                    |
-| #. CPU 0's softirq handler executes and is just about ready to report |
+| #. CPU 0's softirq handler executes and is just about ready to report |
 |    its quiescent state up the ``rcu_node`` tree.                      |
-| #. But CPU 1 beats it to the punch, completing the current grace      |
+| #. But CPU 1 beats it to the punch, completing the current grace      |
 |    period and starting a new one.                                     |
-| #. CPU 0 now reports its quiescent state for the wrong grace period.  |
+| #. CPU 0 now reports its quiescent state for the wrong grace period.  |
 |    That grace period might now end before the RCU read-side critical  |
 |    section. If that happens, disaster will ensue.                     |
 |                                                                       |
@@ -515,18 +515,18 @@ removes itself from the ``->blkd_tasks`` list, then that task must
 advance the pointer to the next task on the list, or set the pointer to
 ``NULL`` if there are no subsequent tasks on the list.
 
-For example, suppose that tasks T1, T2, and T3 are all hard-affinitied
-to the largest-numbered CPU in the system. Then if task T1 blocked in an
+For example, suppose that tasks T1, T2, and T3 are all hard-affinitied
+to the largest-numbered CPU in the system. Then if task T1 blocked in an
 RCU read-side critical section, then an expedited grace period started,
-then task T2 blocked in an RCU read-side critical section, then a normal
-grace period started, and finally task 3 blocked in an RCU read-side
+then task T2 blocked in an RCU read-side critical section, then a normal
+grace period started, and finally task 3 blocked in an RCU read-side
 critical section, then the state of the last leaf ``rcu_node``
 structure's blocked-task list would be as shown below:
 
 .. kernel-figure:: blkd_task.svg
 
-Task T1 is blocking both grace periods, task T2 is blocking only the
-normal grace period, and task T3 is blocking neither grace period. Note
+Task T1 is blocking both grace periods, task T2 is blocking only the
+normal grace period, and task T3 is blocking neither grace period. Note
 that these tasks will not remove themselves from this list immediately
 upon resuming execution. They will instead remain on the list until they
 execute the outermost ``rcu_read_unlock()`` that ends their RCU
@@ -611,7 +611,7 @@ expressions as follows:
    66 #endif
 
 The maximum number of levels in the ``rcu_node`` structure is currently
-limited to four, as specified by lines 21-24 and the structure of the
+limited to four, as specified by lines 21-24 and the structure of the
 subsequent “if” statement. For 32-bit systems, this allows
 16*32*32*32=524,288 CPUs, which should be sufficient for the next few
 years at least. For 64-bit systems, 16*64*64*64=4,194,304 CPUs is
@@ -638,9 +638,9 @@ fields. The number of CPUs per leaf ``rcu_node`` structure is therefore
 limited to 16 given the default value of ``CONFIG_RCU_FANOUT_LEAF``. If
 ``CONFIG_RCU_FANOUT_LEAF`` is unspecified, the value selected is based
 on the word size of the system, just as for ``CONFIG_RCU_FANOUT``.
-Lines 11-19 perform this computation.
+Lines 11-19 perform this computation.
 
-Lines 21-24 compute the maximum number of CPUs supported by a
+Lines 21-24 compute the maximum number of CPUs supported by a
 single-level (which contains a single ``rcu_node`` structure),
 two-level, three-level, and four-level ``rcu_node`` tree, respectively,
 given the fanout specified by ``RCU_FANOUT`` and ``RCU_FANOUT_LEAF``.
@@ -649,18 +649,18 @@ These numbers of CPUs are retained in the ``RCU_FANOUT_1``,
 variables, respectively.
 
 These variables are used to control the C-preprocessor ``#if`` statement
-spanning lines 26-66 that computes the number of ``rcu_node`` structures
+spanning lines 26-66 that computes the number of ``rcu_node`` structures
 required for each level of the tree, as well as the number of levels
 required. The number of levels is placed in the ``NUM_RCU_LVLS``
-C-preprocessor variable by lines 27, 35, 44, and 54. The number of
+C-preprocessor variable by lines 27, 35, 44, and 54. The number of
 ``rcu_node`` structures for the topmost level of the tree is always
 exactly one, and this value is unconditionally placed into
-``NUM_RCU_LVL_0`` by lines 28, 36, 45, and 55. The rest of the levels
+``NUM_RCU_LVL_0`` by lines 28, 36, 45, and 55. The rest of the levels
 (if any) of the ``rcu_node`` tree are computed by dividing the maximum
 number of CPUs by the fanout supported by the number of levels from the
 current level down, rounding up. This computation is performed by
-lines 37, 46-47, and 56-58. Lines 31-33, 40-42, 50-52, and 62-63 create
-initializers for lockdep lock-class names. Finally, lines 64-66 produce
+lines 37, 46-47, and 56-58. Lines 31-33, 40-42, 50-52, and 62-63 create
+initializers for lockdep lock-class names. Finally, lines 64-66 produce
 an error if the maximum number of CPUs is too large for the specified
 fanout.
 
@@ -716,13 +716,13 @@ In this figure, the ``->head`` pointer references the first RCU callback
 in the list. The ``->tails[RCU_DONE_TAIL]`` array element references the
 ``->head`` pointer itself, indicating that none of the callbacks is
 ready to invoke. The ``->tails[RCU_WAIT_TAIL]`` array element references
-callback CB 2's ``->next`` pointer, which indicates that CB 1 and CB 2
+callback CB 2's ``->next`` pointer, which indicates that CB 1 and CB 2
 are both waiting on the current grace period, give or take possible
 disagreements about exactly which grace period is the current one. The
 ``->tails[RCU_NEXT_READY_TAIL]`` array element references the same RCU
 callback that ``->tails[RCU_WAIT_TAIL]`` does, which indicates that
 there are no callbacks waiting on the next RCU grace period. The
-``->tails[RCU_NEXT_TAIL]`` array element references CB 4's ``->next``
+``->tails[RCU_NEXT_TAIL]`` array element references CB 4's ``->next``
 pointer, indicating that all the remaining RCU callbacks have not yet
 been assigned to an RCU grace period. Note that the
 ``->tails[RCU_NEXT_TAIL]`` array element always references the last RCU
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
index 6f89cf1e567d..9450b0673e5a 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst
@@ -304,8 +304,8 @@ representing the elements of the ``->exp_wq[]`` array.
 
 .. kernel-figure:: Funnel0.svg
 
-The next diagram shows the situation after the arrival of Task A and
-Task B at the leftmost and rightmost leaf ``rcu_node`` structures,
+The next diagram shows the situation after the arrival of Task A and
+Task B at the leftmost and rightmost leaf ``rcu_node`` structures,
 respectively. The current value of the ``rcu_state`` structure's
 ``->expedited_sequence`` field is zero, so adding three and clearing the
 bottom bit results in the value two, which both tasks record in the
@@ -313,13 +313,13 @@ bottom bit results in the value two, which both tasks record in the
 
 .. kernel-figure:: Funnel1.svg
 
-Each of Tasks A and B will move up to the root ``rcu_node`` structure.
-Suppose that Task A wins, recording its desired grace-period sequence
+Each of Tasks A and B will move up to the root ``rcu_node`` structure.
+Suppose that Task A wins, recording its desired grace-period sequence
 number and resulting in the state shown below:
 
 .. kernel-figure:: Funnel2.svg
 
-Task A now advances to initiate a new grace period, while Task B moves
+Task A now advances to initiate a new grace period, while Task B moves
 up to the root ``rcu_node`` structure, and, seeing that its desired
 sequence number is already recorded, blocks on ``->exp_wq[1]``.
 
@@ -340,7 +340,7 @@ sequence number is already recorded, blocks on ``->exp_wq[1]``.
 | ``->exp_wq[1]``.                                                      |
 +-----------------------------------------------------------------------+
 
-If Tasks C and D also arrive at this point, they will compute the same
+If Tasks C and D also arrive at this point, they will compute the same
 desired grace-period sequence number, and see that both leaf
 ``rcu_node`` structures already have that value recorded. They will
 therefore block on their respective ``rcu_node`` structures'
@@ -348,52 +348,52 @@ therefore block on their respective ``rcu_node`` structures'
 
 .. kernel-figure:: Funnel3.svg
 
-Task A now acquires the ``rcu_state`` structure's ``->exp_mutex`` and
+Task A now acquires the ``rcu_state`` structure's ``->exp_mutex`` and
 initiates the grace period, which increments ``->expedited_sequence``.
-Therefore, if Tasks E and F arrive, they will compute a desired sequence
+Therefore, if Tasks E and F arrive, they will compute a desired sequence
 number of 4 and will record this value as shown below:
 
 .. kernel-figure:: Funnel4.svg
 
-Tasks E and F will propagate up the ``rcu_node`` combining tree, with
-Task F blocking on the root ``rcu_node`` structure and Task E wait for
-Task A to finish so that it can start the next grace period. The
+Tasks E and F will propagate up the ``rcu_node`` combining tree, with
+Task F blocking on the root ``rcu_node`` structure and Task E wait for
+Task A to finish so that it can start the next grace period. The
 resulting state is as shown below:
 
 .. kernel-figure:: Funnel5.svg
 
-Once the grace period completes, Task A starts waking up the tasks
+Once the grace period completes, Task A starts waking up the tasks
 waiting for this grace period to complete, increments the
 ``->expedited_sequence``, acquires the ``->exp_wake_mutex`` and then
 releases the ``->exp_mutex``. This results in the following state:
 
 .. kernel-figure:: Funnel6.svg
 
-Task E can then acquire ``->exp_mutex`` and increment
-``->expedited_sequence`` to the value three. If new tasks G and H arrive
+Task E can then acquire ``->exp_mutex`` and increment
+``->expedited_sequence`` to the value three. If new tasks G and H arrive
 and moves up the combining tree at the same time, the state will be as
 follows:
 
 .. kernel-figure:: Funnel7.svg
 
 Note that three of the root ``rcu_node`` structure's waitqueues are now
-occupied. However, at some point, Task A will wake up the tasks blocked
+occupied. However, at some point, Task A will wake up the tasks blocked
 on the ``->exp_wq`` waitqueues, resulting in the following state:
 
 .. kernel-figure:: Funnel8.svg
 
-Execution will continue with Tasks E and H completing their grace
+Execution will continue with Tasks E and H completing their grace
 periods and carrying out their wakeups.
 
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| What happens if Task A takes so long to do its wakeups that Task E's  |
+| What happens if Task A takes so long to do its wakeups that Task E's  |
 | grace period completes?                                               |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| Then Task E will block on the ``->exp_wake_mutex``, which will also   |
+| Then Task E will block on the ``->exp_wake_mutex``, which will also   |
 | prevent it from releasing ``->exp_mutex``, which in turn will prevent |
 | the next grace period from starting. This last is important in        |
 | preventing overflow of the ``->exp_wq[]`` array.                      |
diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index a648b423ba0e..39b8cf542006 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -215,7 +215,7 @@ newly arrived RCU callbacks against future grace periods:
    43 }
 
 But the only part of ``rcu_prepare_for_idle()`` that really matters for
-this discussion are lines 37–39. We will therefore abbreviate this
+this discussion are lines 37–39. We will therefore abbreviate this
 function as follows:
 
 .. kernel-figure:: rcu_node-lock.svg
diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 38a39476fc24..35d6a02a3e73 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -4,7 +4,7 @@ A Tour Through RCU's Requirements
 
 Copyright IBM Corporation, 2015
 
-Author: Paul E. McKenney
+Author: Paul E. McKenney
 
 The initial version of this document appeared in the
 `LWN <https://lwn.net/>`_ on those articles:
@@ -102,7 +102,7 @@ overhead to readers, for example:
       15   WRITE_ONCE(y, 1);
       16 }
 
-Because the synchronize_rcu() on line 14 waits for all pre-existing
+Because the synchronize_rcu() on line 14 waits for all pre-existing
 readers, any instance of thread0() that loads a value of zero from
 ``x`` must complete before thread1() stores to ``y``, so that
 instance must also load a value of zero from ``y``. Similarly, any
@@ -178,7 +178,7 @@ little or no synchronization overhead in do_something_dlm().
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Why is the synchronize_rcu() on line 28 needed?                       |
+| Why is the synchronize_rcu() on line 28 needed?                       |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
@@ -244,7 +244,7 @@ their rights to reorder this code as follows:
       16 }
 
 If an RCU reader fetches ``gp`` just after ``add_gp_buggy_optimized``
-executes line 11, it will see garbage in the ``->a`` and ``->b`` fields.
+executes line 11, it will see garbage in the ``->a`` and ``->b`` fields.
 And this is but one of many ways in which compiler and hardware
 optimizations could cause trouble. Therefore, we clearly need some way
 to prevent the compiler and the CPU from reordering in this manner,
@@ -279,9 +279,9 @@ shows an example of insertion:
       15   return true;
       16 }
 
-The rcu_assign_pointer() on line 13 is conceptually equivalent to a
+The rcu_assign_pointer() on line 13 is conceptually equivalent to a
 simple assignment statement, but also guarantees that its assignment
-will happen after the two assignments in lines 11 and 12, similar to the
+will happen after the two assignments in lines 11 and 12, similar to the
 C11 ``memory_order_release`` store operation. It also prevents any
 number of “interesting” compiler optimizations, for example, the use of
 ``gp`` as a scratch location immediately preceding the assignment.
@@ -410,11 +410,11 @@ This process is implemented by remove_gp_synchronous():
       15   return true;
       16 }
 
-This function is straightforward, with line 13 waiting for a grace
-period before line 14 frees the old data element. This waiting ensures
-that readers will reach line 7 of do_something_gp() before the data
+This function is straightforward, with line 13 waiting for a grace
+period before line 14 frees the old data element. This waiting ensures
+that readers will reach line 7 of do_something_gp() before the data
 element referenced by ``p`` is freed. The rcu_access_pointer() on
-line 6 is similar to rcu_dereference(), except that:
+line 6 is similar to rcu_dereference(), except that:
 
 #. The value returned by rcu_access_pointer() cannot be
    dereferenced. If you want to access the value pointed to as well as
@@ -488,25 +488,25 @@ systems with more than one CPU:
    section ends and the time that synchronize_rcu() returns. Without
    this guarantee, a pre-existing RCU read-side critical section might
    hold a reference to the newly removed ``struct foo`` after the
-   kfree() on line 14 of remove_gp_synchronous().
+   kfree() on line 14 of remove_gp_synchronous().
 #. Each CPU that has an RCU read-side critical section that ends after
    synchronize_rcu() returns is guaranteed to execute a full memory
    barrier between the time that synchronize_rcu() begins and the
    time that the RCU read-side critical section begins. Without this
    guarantee, a later RCU read-side critical section running after the
-   kfree() on line 14 of remove_gp_synchronous() might later run
+   kfree() on line 14 of remove_gp_synchronous() might later run
    do_something_gp() and find the newly deleted ``struct foo``.
 #. If the task invoking synchronize_rcu() remains on a given CPU,
    then that CPU is guaranteed to execute a full memory barrier sometime
    during the execution of synchronize_rcu(). This guarantee ensures
-   that the kfree() on line 14 of remove_gp_synchronous() really
-   does execute after the removal on line 11.
+   that the kfree() on line 14 of remove_gp_synchronous() really
+   does execute after the removal on line 11.
 #. If the task invoking synchronize_rcu() migrates among a group of
    CPUs during that invocation, then each of the CPUs in that group is
    guaranteed to execute a full memory barrier sometime during the
    execution of synchronize_rcu(). This guarantee also ensures that
-   the kfree() on line 14 of remove_gp_synchronous() really does
-   execute after the removal on line 11, but also in the case where the
+   the kfree() on line 14 of remove_gp_synchronous() really does
+   execute after the removal on line 11, but also in the case where the
    thread executing the synchronize_rcu() migrates in the meantime.
 
 +-----------------------------------------------------------------------+
@@ -538,7 +538,7 @@ systems with more than one CPU:
 | of any access following the grace period.                             |
 |                                                                       |
 | As of late 2016, mathematical models of RCU take this viewpoint, for  |
-| example, see slides 62 and 63 of the `2016 LinuxCon                   |
+| example, see slides 62 and 63 of the `2016 LinuxCon                   |
 | EU <http://www2.rdrop.com/users/paulmck/scalability/paper/LinuxMM.201 |
 | 6.10.04c.LCE.pdf>`__                                                  |
 | presentation.                                                         |
@@ -584,7 +584,7 @@ systems with more than one CPU:
 |                                                                       |
 | And similarly, without a memory barrier between the beginning of the  |
 | grace period and the beginning of the RCU read-side critical section, |
-| CPU 1 might end up accessing the freelist.                            |
+| CPU 1 might end up accessing the freelist.                            |
 |                                                                       |
 | The “as if” rule of course applies, so that any implementation that   |
 | acts as if the appropriate memory barriers were in place is a correct |
@@ -1274,8 +1274,8 @@ be used in place of synchronize_rcu() as follows:
       28 }
 
 A definition of ``struct foo`` is finally needed, and appears on
-lines 1-5. The function remove_gp_cb() is passed to call_rcu()
-on line 25, and will be invoked after the end of a subsequent grace
+lines 1-5. The function remove_gp_cb() is passed to call_rcu()
+on line 25, and will be invoked after the end of a subsequent grace
 period. This gets the same effect as remove_gp_synchronous(), but
 without forcing the updater to wait for a grace period to elapse. The
 call_rcu() function may be used in a number of situations where
@@ -1294,17 +1294,17 @@ threads or (in the Linux kernel) workqueues.
 +-----------------------------------------------------------------------+
 | **Quick Quiz**:                                                       |
 +-----------------------------------------------------------------------+
-| Why does line 19 use rcu_access_pointer()? After all,                 |
-| call_rcu() on line 25 stores into the structure, which would          |
+| Why does line 19 use rcu_access_pointer()? After all,                 |
+| call_rcu() on line 25 stores into the structure, which would          |
 | interact badly with concurrent insertions. Doesn't this mean that     |
 | rcu_dereference() is required?                                        |
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| Presumably the ``->gp_lock`` acquired on line 18 excludes any         |
+| Presumably the ``->gp_lock`` acquired on line 18 excludes any         |
 | changes, including any insertions that rcu_dereference() would        |
 | protect against. Therefore, any insertions will be delayed until      |
-| after ``->gp_lock`` is released on line 25, which in turn means that  |
+| after ``->gp_lock`` is released on line 25, which in turn means that  |
 | rcu_access_pointer() suffices.                                        |
 +-----------------------------------------------------------------------+
 
@@ -1396,8 +1396,8 @@ may be used for this purpose, as shown below:
       18   return true;
       19 }
 
-On line 14, get_state_synchronize_rcu() obtains a “cookie” from RCU,
-then line 15 carries out other tasks, and finally, line 16 returns
+On line 14, get_state_synchronize_rcu() obtains a “cookie” from RCU,
+then line 15 carries out other tasks, and finally, line 16 returns
 immediately if a grace period has elapsed in the meantime, but otherwise
 waits as required. The need for ``get_state_synchronize_rcu`` and
 cond_synchronize_rcu() has appeared quite recently, so it is too
@@ -1420,9 +1420,9 @@ example, an infinite loop in an RCU read-side critical section must by
 definition prevent later grace periods from ever completing. For a more
 involved example, consider a 64-CPU system built with
 ``CONFIG_RCU_NOCB_CPU=y`` and booted with ``rcu_nocbs=1-63``, where
-CPUs 1 through 63 spin in tight loops that invoke call_rcu(). Even
+CPUs 1 through 63 spin in tight loops that invoke call_rcu(). Even
 if these tight loops also contain calls to cond_resched() (thus
-allowing grace periods to complete), CPU 0 simply will not be able to
+allowing grace periods to complete), CPU 0 simply will not be able to
 invoke callbacks as fast as the other 63 CPUs can register them, at
 least not until the system runs out of memory. In both of these
 examples, the Spiderman principle applies: With great power comes great
@@ -1433,7 +1433,7 @@ callbacks.
 RCU takes the following steps to encourage timely completion of grace
 periods:
 
-#. If a grace period fails to complete within 100 milliseconds, RCU
+#. If a grace period fails to complete within 100 milliseconds, RCU
    causes future invocations of cond_resched() on the holdout CPUs
    to provide an RCU quiescent state. RCU also causes those CPUs'
    need_resched() invocations to return ``true``, but only after the
@@ -1442,12 +1442,12 @@ periods:
    indefinitely in the kernel without scheduling-clock interrupts, which
    defeats the above need_resched() strategem. RCU will therefore
    invoke resched_cpu() on any ``nohz_full`` CPUs still holding out
-   after 109 milliseconds.
+   after 109 milliseconds.
 #. In kernels built with ``CONFIG_RCU_BOOST=y``, if a given task that
    has been preempted within an RCU read-side critical section is
-   holding out for more than 500 milliseconds, RCU will resort to
+   holding out for more than 500 milliseconds, RCU will resort to
    priority boosting.
-#. If a CPU is still holding out 10 seconds into the grace period, RCU
+#. If a CPU is still holding out 10 seconds into the grace period, RCU
    will invoke resched_cpu() on it regardless of its ``nohz_full``
    state.
 
@@ -2536,9 +2536,9 @@ period to elapse. For example, this results in a self-deadlock:
        5 synchronize_srcu(&ss);
        6 srcu_read_unlock(&ss, idx);
 
-However, if line 5 acquired a mutex that was held across a
+However, if line 5 acquired a mutex that was held across a
 synchronize_srcu() for domain ``ss``, deadlock would still be
-possible. Furthermore, if line 5 acquired a mutex that was held across a
+possible. Furthermore, if line 5 acquired a mutex that was held across a
 synchronize_srcu() for some other domain ``ss1``, and if an
 ``ss1``-domain SRCU read-side critical section acquired another mutex
 that was held across as ``ss``-domain synchronize_srcu(), deadlock
@@ -2573,7 +2573,7 @@ period has the side effect of expediting all prior grace periods that
 have not yet completed. (But please note that this is a property of the
 current implementation, not necessarily of future implementations.) In
 addition, if SRCU has been idle for longer than the interval specified
-by the ``srcutree.exp_holdoff`` kernel boot parameter (25 microseconds
+by the ``srcutree.exp_holdoff`` kernel boot parameter (25 microseconds
 by default), and if a synchronize_srcu() invocation ends this idle
 period, that invocation will be automatically expedited.
 
-- 
2.31.1

