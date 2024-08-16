Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F9266A7;
	Fri, 16 Aug 2024 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723780841; cv=none; b=K3nKEFhtGeQIL/gT9k78+3Q8kwwhnBGCFSPOOYduC3yDKuUabullMQovGYNuhrLn/CXqsAcfKzHo1EeEkbG793UPxk7kQdO7rUGlTswnxJ4A0N+48uMt+lVG0aVD5D59GT5W7sUreLbmc8fJeTP+QQJx2LuPKGzDnGLnyXwP5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723780841; c=relaxed/simple;
	bh=14bO23BFaENGsNPHz7uqU+Sqcoq2xGm6aqCoPV+kIYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JSXYZoXZ6Ir2v1xpZ6qyQ9YzFZa5Mb7r0RJXZsbWhn4vJWJ+43UEzd2jLfBWNvgyO9spLviVlNmY9YpqkTEe3P9xV67CoiKmlJ79EUONv6RmhwF4T1B0T9iyGkg0tC7cyPBoqffC87zlHJV4LXrBN7Vu1yMlk93L+QwaNRte40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/AA5gUk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/AA5gUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DFAC32782;
	Fri, 16 Aug 2024 04:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723780841;
	bh=14bO23BFaENGsNPHz7uqU+Sqcoq2xGm6aqCoPV+kIYc=;
	h=Date:From:To:Cc:Subject:From;
	b=j/AA5gUkZ94FvU5x19njMDP+foM42R/XXhON7CxXcJ9TUwIcFuS731gf9oitxsxDe
	 +RRvL0m1HIa70gMK60p3OBhJvAhvQFw62obzFD08GLCUypyxaq0Mhx9mZuqDyNh4aC
	 Ab5kA369iSMzuVshXYoeal1UlYReDeoEX5WQXtuPwQTj2chycFa9w6SETkzBjK+g0D
	 Ms7+dT6ddWdbO9SkWlDJ5nchKgWUNUcZxfIK9xjiv6aBBrHzo35+pUxmpriNgHRC9E
	 yXEZg8K8Fal5ddgA7QRH0Wn1dL5FKM8TlE5l6+AdNBQx7c1ctGji3gaAlcVjZ8awdR
	 ofUGsu2MCBNGg==
Date: Fri, 16 Aug 2024 09:30:30 +0530
From: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
To: rcu@vger.kernel.org
Cc: paulmck@kernel.org, joel@joelfernandes.org, frederic@kernel.org,
	boqun.feng@gmail.com, urezki@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, seanjc@google.com, vschneid@redhat.com
Subject: [PATCH rcu 0/26] Context tracking updates for v6.12
Message-ID: <20240816040030.GA16986@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This patch series contains following updates to the context
tracking code (rebased on v6.11-rc1):

1. Renaming of context tracking state related symbols and removal of
   references to "dynticks" in various context tracking state variables
   and related helpers, courtesy of Valentin Schneider.

2. Tagging context_tracking_enabled_this_cpu() __always_inline, courtesy of
   Sean Christopherson.


Git tree is at https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/log/?h=context_tracking.15.08.24a


- Neeraj


Sean Christopherson (1):
  context_tracking: Tag context_tracking_enabled_this_cpu()
    __always_inline

Valentin Schneider (25):
  treewide: context_tracking: Rename CONTEXT_* into CT_STATE_*
  context_tracking, rcu: Rename RCU_DYNTICKS_IDX into CT_RCU_WATCHING
  context_tracking, rcu: Rename ct_dynticks() into ct_rcu_watching()
  context_tracking, rcu: Rename ct_dynticks_cpu() into
    ct_rcu_watching_cpu()
  context_tracking, rcu: Rename ct_dynticks_cpu_acquire() into
    ct_rcu_watching_cpu_acquire()
  context_tracking, rcu: Rename struct context_tracking
    .dynticks_nesting into .nesting
  context_tracking, rcu: Rename ct_dynticks_nesting() into ct_nesting()
  context_tracking, rcu: Rename ct_dynticks_nesting_cpu() into
    ct_nesting_cpu()
  context_tracking, rcu: Rename struct context_tracking
    .dynticks_nmi_nesting into .nmi_nesting
  context_tracking, rcu: Rename ct_dynticks_nmi_nesting() into
    ct_nmi_nesting()
  context_tracking, rcu: Rename ct_dynticks_nmi_nesting_cpu() into
    ct_nmi_nesting_cpu()
  context_tracking, rcu: Rename DYNTICK_IRQ_NONIDLE into
    CT_NESTING_IRQ_NONIDLE
  context_tracking, rcu: Rename rcu_dynticks_task*() into rcu_task*()
  context_tracking, rcu: Rename rcu_dynticks_curr_cpu_in_eqs() into
    rcu_is_watching_curr_cpu()
  rcu: Rename rcu_dynticks_eqs_online() into rcu_watching_online()
  rcu: Rename rcu_dynticks_in_eqs() into rcu_watching_snap_in_eqs()
  rcu: Rename rcu_dynticks_in_eqs_since() into
    rcu_watching_snap_stopped_since()
  rcu: Rename rcu_dynticks_zero_in_eqs() into rcu_watching_zero_in_eqs()
  rcu: Rename struct rcu_data .dynticks_snap into .watching_snap
  rcu: Rename struct rcu_data .exp_dynticks_snap into .exp_watching_snap
  rcu: Rename dyntick_save_progress_counter() into
    rcu_watching_snap_save()
  rcu: Rename rcu_implicit_dynticks_qs() into
    rcu_watching_snap_recheck()
  rcu: Rename rcu_momentary_dyntick_idle() into rcu_momentary_eqs()
  rcu: Update stray documentation references to rcu_dynticks_eqs_{enter,
    exit}()
  context_tracking, rcu: Rename rcu_dyntick trace event into
    rcu_watching

 .../Data-Structures/Data-Structures.rst       |  28 ++--
 .../Tree-RCU-Memory-Ordering.rst              |   8 +-
 .../Memory-Ordering/TreeRCU-dyntick.svg       |   8 +-
 .../Design/Memory-Ordering/TreeRCU-gp-fqs.svg |   8 +-
 .../RCU/Design/Memory-Ordering/TreeRCU-gp.svg |   8 +-
 .../Memory-Ordering/TreeRCU-hotplug.svg       |   4 +-
 arch/Kconfig                                  |   2 +-
 arch/arm64/kernel/entry-common.c              |   2 +-
 arch/powerpc/include/asm/interrupt.h          |   6 +-
 arch/powerpc/kernel/interrupt.c               |   6 +-
 arch/powerpc/kernel/syscall.c                 |   2 +-
 arch/x86/entry/common.c                       |   2 +-
 include/linux/context_tracking.h              |  32 ++--
 include/linux/context_tracking_state.h        |  60 ++++----
 include/linux/entry-common.h                  |   2 +-
 include/linux/rcutiny.h                       |   2 +-
 include/linux/rcutree.h                       |   2 +-
 include/trace/events/rcu.h                    |  20 +--
 kernel/context_tracking.c                     | 140 +++++++++---------
 kernel/entry/common.c                         |   2 +-
 kernel/rcu/rcu.h                              |   4 +-
 kernel/rcu/rcutorture.c                       |   4 +-
 kernel/rcu/tasks.h                            |   2 +-
 kernel/rcu/tree.c                             | 111 +++++++-------
 kernel/rcu/tree.h                             |   4 +-
 kernel/rcu/tree_exp.h                         |   8 +-
 kernel/rcu/tree_nocb.h                        |   2 +-
 kernel/rcu/tree_plugin.h                      |   6 +-
 kernel/rcu/tree_stall.h                       |   6 +-
 kernel/sched/core.c                           |   4 +-
 kernel/stop_machine.c                         |   2 +-
 kernel/trace/trace_osnoise.c                  |   4 +-
 32 files changed, 258 insertions(+), 243 deletions(-)

