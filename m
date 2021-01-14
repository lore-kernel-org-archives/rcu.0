Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9839CC433DB
	for <rcu@archiver.kernel.org>; Thu, 14 Jan 2021 15:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C0523A5F
	for <rcu@archiver.kernel.org>; Thu, 14 Jan 2021 15:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbhANPGy (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 14 Jan 2021 10:06:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbhANPGx (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 14 Jan 2021 10:06:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB4F823A7E;
        Thu, 14 Jan 2021 15:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610636768;
        bh=24lDA1TjDkFOsByrHmUQ88YGn5yDQSiyi3MaHQPjbFI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MT6e3nf6cUp/8qG4MVijtz4JBwnRdPij4KZxAiwV+EUojFJvD59r2tZQLyiFJ4WVO
         RB7olxiDzZtEczjxycc1viKaW2p1Gmwc8konFhLztXoQiynAjjESgcDp7cJWMJUSzy
         mozRJL3Xoz8lkxPSdfISbZ7wQ8SN3BTzXmlVrGkH+4BEopEICRQGG8DSuENoS1LI/d
         sq7BMc7M6Q+0Kov2hmc44+x/8nGOj8oKPa9Ezcj7F1COC2N5S0Vc2743O8dIBovRiC
         sk0+G3at+r2sJiA+3d0r8RW19bghwRt16jV09LY0C100wP0A8MEsKa0Fy+t92XHiSE
         F1ByjHZjXiBnw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7BDF335225DC; Thu, 14 Jan 2021 07:06:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 07:06:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] drivers: Remove CONFIG_OPROFILE support
Message-ID: <20210114150608.GF2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <08ecfc3e3fe1a01ad1e360e4afb7ffc8666a2676.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ecfc3e3fe1a01ad1e360e4afb7ffc8666a2676.1610622251.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 14, 2021 at 05:05:30PM +0530, Viresh Kumar wrote:
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
> 
> Remove kernel's old oprofile support.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

For the RCU update:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  Documentation/RCU/NMI-RCU.rst                 |   3 +-
>  .../admin-guide/kernel-parameters.txt         |  14 -
>  Documentation/process/magic-number.rst        |   1 -
>  .../it_IT/process/magic-number.rst            |   1 -
>  .../zh_CN/process/magic-number.rst            |   1 -
>  MAINTAINERS                                   |  11 -
>  arch/Kconfig                                  |  32 -
>  drivers/oprofile/buffer_sync.c                | 591 ------------------
>  drivers/oprofile/buffer_sync.h                |  22 -
>  drivers/oprofile/cpu_buffer.c                 | 465 --------------
>  drivers/oprofile/cpu_buffer.h                 | 121 ----
>  drivers/oprofile/event_buffer.c               | 209 -------
>  drivers/oprofile/event_buffer.h               |  40 --
>  drivers/oprofile/nmi_timer_int.c              | 157 -----
>  drivers/oprofile/oprof.c                      | 286 ---------
>  drivers/oprofile/oprof.h                      |  50 --
>  drivers/oprofile/oprofile_files.c             | 201 ------
>  drivers/oprofile/oprofile_perf.c              | 328 ----------
>  drivers/oprofile/oprofile_stats.c             |  84 ---
>  drivers/oprofile/oprofile_stats.h             |  33 -
>  drivers/oprofile/oprofilefs.c                 | 300 ---------
>  drivers/oprofile/timer_int.c                  | 122 ----
>  include/linux/oprofile.h                      | 209 -------
>  init/Kconfig                                  |   2 +-
>  24 files changed, 2 insertions(+), 3281 deletions(-)
>  delete mode 100644 drivers/oprofile/buffer_sync.c
>  delete mode 100644 drivers/oprofile/buffer_sync.h
>  delete mode 100644 drivers/oprofile/cpu_buffer.c
>  delete mode 100644 drivers/oprofile/cpu_buffer.h
>  delete mode 100644 drivers/oprofile/event_buffer.c
>  delete mode 100644 drivers/oprofile/event_buffer.h
>  delete mode 100644 drivers/oprofile/nmi_timer_int.c
>  delete mode 100644 drivers/oprofile/oprof.c
>  delete mode 100644 drivers/oprofile/oprof.h
>  delete mode 100644 drivers/oprofile/oprofile_files.c
>  delete mode 100644 drivers/oprofile/oprofile_perf.c
>  delete mode 100644 drivers/oprofile/oprofile_stats.c
>  delete mode 100644 drivers/oprofile/oprofile_stats.h
>  delete mode 100644 drivers/oprofile/oprofilefs.c
>  delete mode 100644 drivers/oprofile/timer_int.c
>  delete mode 100644 include/linux/oprofile.h
> 
> diff --git a/Documentation/RCU/NMI-RCU.rst b/Documentation/RCU/NMI-RCU.rst
> index 180958388ff9..2a92bc685ef1 100644
> --- a/Documentation/RCU/NMI-RCU.rst
> +++ b/Documentation/RCU/NMI-RCU.rst
> @@ -8,8 +8,7 @@ Although RCU is usually used to protect read-mostly data structures,
>  it is possible to use RCU to provide dynamic non-maskable interrupt
>  handlers, as well as dynamic irq handlers.  This document describes
>  how to do this, drawing loosely from Zwane Mwaikambo's NMI-timer
> -work in "arch/x86/oprofile/nmi_timer_int.c" and in
> -"arch/x86/kernel/traps.c".
> +work in "arch/x86/kernel/traps.c".
>  
>  The relevant pieces of code are listed below, each followed by a
>  brief explanation::
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e3cdb271d06..e860c681766b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3458,20 +3458,6 @@
>  			For example, to override I2C bus2:
>  			omap_mux=i2c2_scl.i2c2_scl=0x100,i2c2_sda.i2c2_sda=0x100
>  
> -	oprofile.timer=	[HW]
> -			Use timer interrupt instead of performance counters
> -
> -	oprofile.cpu_type=	Force an oprofile cpu type
> -			This might be useful if you have an older oprofile
> -			userland or if you want common events.
> -			Format: { arch_perfmon }
> -			arch_perfmon: [X86] Force use of architectural
> -				perfmon on Intel CPUs instead of the
> -				CPU specific event set.
> -			timer: [X86] Force use of architectural NMI
> -				timer mode (see also oprofile.timer
> -				for generic hr timer mode)
> -
>  	oops=panic	Always panic on oopses. Default is to just kill the
>  			process, but there is a small probability of
>  			deadlocking the machine.
> diff --git a/Documentation/process/magic-number.rst b/Documentation/process/magic-number.rst
> index e02ff5ffb653..c6dfe060ec2f 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -135,7 +135,6 @@ FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/atm/fo
>  SLOT_MAGIC            0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
>  SLOT_MAGIC            0x67267322       slot                     ``drivers/hotplug/acpiphp.h``
>  LO_MAGIC              0x68797548       nbd_device               ``include/linux/nbd.h``
> -OPROFILE_MAGIC        0x6f70726f       super_block              ``drivers/oprofile/oprofilefs.h``
>  M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/oss/maestro3.c``
>  VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/core/memory.c``
>  KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/core/memory.c``
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/Documentation/translations/it_IT/process/magic-number.rst
> index 0243d32a0b59..1af30f4228f2 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -141,7 +141,6 @@ FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/atm/fo
>  SLOT_MAGIC            0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
>  SLOT_MAGIC            0x67267322       slot                     ``drivers/hotplug/acpiphp.h``
>  LO_MAGIC              0x68797548       nbd_device               ``include/linux/nbd.h``
> -OPROFILE_MAGIC        0x6f70726f       super_block              ``drivers/oprofile/oprofilefs.h``
>  M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/oss/maestro3.c``
>  VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/core/memory.c``
>  KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/core/memory.c``
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/Documentation/translations/zh_CN/process/magic-number.rst
> index de182bf4191c..7bb9d4165ed3 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -124,7 +124,6 @@ FW_HEADER_MAGIC       0x65726F66       fw_header                ``drivers/atm/fo
>  SLOT_MAGIC            0x67267321       slot                     ``drivers/hotplug/cpqphp.h``
>  SLOT_MAGIC            0x67267322       slot                     ``drivers/hotplug/acpiphp.h``
>  LO_MAGIC              0x68797548       nbd_device               ``include/linux/nbd.h``
> -OPROFILE_MAGIC        0x6f70726f       super_block              ``drivers/oprofile/oprofilefs.h``
>  M3_STATE_MAGIC        0x734d724d       m3_state                 ``sound/oss/maestro3.c``
>  VMALLOC_MAGIC         0x87654320       snd_alloc_track          ``sound/core/memory.c``
>  KMALLOC_MAGIC         0x87654321       snd_alloc_track          ``sound/core/memory.c``
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc1e6a5ee6e6..ae2c2cef9d96 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1414,7 +1414,6 @@ F:	arch/arm*/include/asm/hw_breakpoint.h
>  F:	arch/arm*/include/asm/perf_event.h
>  F:	arch/arm*/kernel/hw_breakpoint.c
>  F:	arch/arm*/kernel/perf_*
> -F:	arch/arm/oprofile/common.c
>  F:	drivers/perf/
>  F:	include/linux/perf/arm_pmu.h
>  
> @@ -4083,7 +4082,6 @@ W:	http://www.ibm.com/developerworks/power/cell/
>  F:	arch/powerpc/include/asm/cell*.h
>  F:	arch/powerpc/include/asm/spu*.h
>  F:	arch/powerpc/include/uapi/asm/spu*.h
> -F:	arch/powerpc/oprofile/*cell*
>  F:	arch/powerpc/platforms/cell/
>  
>  CELLWISE CW2015 BATTERY DRIVER
> @@ -13311,15 +13309,6 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>  F:	sound/drivers/opl4/
>  
> -OPROFILE
> -M:	Robert Richter <rric@kernel.org>
> -L:	oprofile-list@lists.sf.net
> -S:	Maintained
> -F:	arch/*/include/asm/oprofile*.h
> -F:	arch/*/oprofile/
> -F:	drivers/oprofile/
> -F:	include/linux/oprofile.h
> -
>  ORACLE CLUSTER FILESYSTEM 2 (OCFS2)
>  M:	Mark Fasheh <mark@fasheh.com>
>  M:	Joel Becker <jlbec@evilplan.org>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 24862d15f3a3..40277027a255 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -33,38 +33,6 @@ config HOTPLUG_SMT
>  config GENERIC_ENTRY
>         bool
>  
> -config OPROFILE
> -	tristate "OProfile system profiling"
> -	depends on PROFILING
> -	depends on HAVE_OPROFILE
> -	select RING_BUFFER
> -	select RING_BUFFER_ALLOW_SWAP
> -	help
> -	  OProfile is a profiling system capable of profiling the
> -	  whole system, include the kernel, kernel modules, libraries,
> -	  and applications.
> -
> -	  If unsure, say N.
> -
> -config OPROFILE_EVENT_MULTIPLEX
> -	bool "OProfile multiplexing support (EXPERIMENTAL)"
> -	default n
> -	depends on OPROFILE && X86
> -	help
> -	  The number of hardware counters is limited. The multiplexing
> -	  feature enables OProfile to gather more events than counters
> -	  are provided by the hardware. This is realized by switching
> -	  between events at a user specified time interval.
> -
> -	  If unsure, say N.
> -
> -config HAVE_OPROFILE
> -	bool
> -
> -config OPROFILE_NMI_TIMER
> -	def_bool y
> -	depends on PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !PPC64
> -
>  config KPROBES
>  	bool "Kprobes"
>  	depends on MODULES
> diff --git a/drivers/oprofile/buffer_sync.c b/drivers/oprofile/buffer_sync.c
> deleted file mode 100644
> index cc917865f13a..000000000000
> --- a/drivers/oprofile/buffer_sync.c
> +++ /dev/null
> @@ -1,591 +0,0 @@
> -/**
> - * @file buffer_sync.c
> - *
> - * @remark Copyright 2002-2009 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - * @author Barry Kasindorf
> - * @author Robert Richter <robert.richter@amd.com>
> - *
> - * This is the core of the buffer management. Each
> - * CPU buffer is processed and entered into the
> - * global event buffer. Such processing is necessary
> - * in several circumstances, mentioned below.
> - *
> - * The processing does the job of converting the
> - * transitory EIP value into a persistent dentry/offset
> - * value that the profiler can record at its leisure.
> - *
> - * See fs/dcookies.c for a description of the dentry/offset
> - * objects.
> - */
> -
> -#include <linux/file.h>
> -#include <linux/mm.h>
> -#include <linux/workqueue.h>
> -#include <linux/notifier.h>
> -#include <linux/dcookies.h>
> -#include <linux/profile.h>
> -#include <linux/module.h>
> -#include <linux/fs.h>
> -#include <linux/oprofile.h>
> -#include <linux/sched.h>
> -#include <linux/sched/mm.h>
> -#include <linux/sched/task.h>
> -#include <linux/gfp.h>
> -
> -#include "oprofile_stats.h"
> -#include "event_buffer.h"
> -#include "cpu_buffer.h"
> -#include "buffer_sync.h"
> -
> -static LIST_HEAD(dying_tasks);
> -static LIST_HEAD(dead_tasks);
> -static cpumask_var_t marked_cpus;
> -static DEFINE_SPINLOCK(task_mortuary);
> -static void process_task_mortuary(void);
> -
> -/* Take ownership of the task struct and place it on the
> - * list for processing. Only after two full buffer syncs
> - * does the task eventually get freed, because by then
> - * we are sure we will not reference it again.
> - * Can be invoked from softirq via RCU callback due to
> - * call_rcu() of the task struct, hence the _irqsave.
> - */
> -static int
> -task_free_notify(struct notifier_block *self, unsigned long val, void *data)
> -{
> -	unsigned long flags;
> -	struct task_struct *task = data;
> -	spin_lock_irqsave(&task_mortuary, flags);
> -	list_add(&task->tasks, &dying_tasks);
> -	spin_unlock_irqrestore(&task_mortuary, flags);
> -	return NOTIFY_OK;
> -}
> -
> -
> -/* The task is on its way out. A sync of the buffer means we can catch
> - * any remaining samples for this task.
> - */
> -static int
> -task_exit_notify(struct notifier_block *self, unsigned long val, void *data)
> -{
> -	/* To avoid latency problems, we only process the current CPU,
> -	 * hoping that most samples for the task are on this CPU
> -	 */
> -	sync_buffer(raw_smp_processor_id());
> -	return 0;
> -}
> -
> -
> -/* The task is about to try a do_munmap(). We peek at what it's going to
> - * do, and if it's an executable region, process the samples first, so
> - * we don't lose any. This does not have to be exact, it's a QoI issue
> - * only.
> - */
> -static int
> -munmap_notify(struct notifier_block *self, unsigned long val, void *data)
> -{
> -	unsigned long addr = (unsigned long)data;
> -	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *mpnt;
> -
> -	mmap_read_lock(mm);
> -
> -	mpnt = find_vma(mm, addr);
> -	if (mpnt && mpnt->vm_file && (mpnt->vm_flags & VM_EXEC)) {
> -		mmap_read_unlock(mm);
> -		/* To avoid latency problems, we only process the current CPU,
> -		 * hoping that most samples for the task are on this CPU
> -		 */
> -		sync_buffer(raw_smp_processor_id());
> -		return 0;
> -	}
> -
> -	mmap_read_unlock(mm);
> -	return 0;
> -}
> -
> -
> -/* We need to be told about new modules so we don't attribute to a previously
> - * loaded module, or drop the samples on the floor.
> - */
> -static int
> -module_load_notify(struct notifier_block *self, unsigned long val, void *data)
> -{
> -#ifdef CONFIG_MODULES
> -	if (val != MODULE_STATE_COMING)
> -		return NOTIFY_DONE;
> -
> -	/* FIXME: should we process all CPU buffers ? */
> -	mutex_lock(&buffer_mutex);
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(MODULE_LOADED_CODE);
> -	mutex_unlock(&buffer_mutex);
> -#endif
> -	return NOTIFY_OK;
> -}
> -
> -
> -static struct notifier_block task_free_nb = {
> -	.notifier_call	= task_free_notify,
> -};
> -
> -static struct notifier_block task_exit_nb = {
> -	.notifier_call	= task_exit_notify,
> -};
> -
> -static struct notifier_block munmap_nb = {
> -	.notifier_call	= munmap_notify,
> -};
> -
> -static struct notifier_block module_load_nb = {
> -	.notifier_call = module_load_notify,
> -};
> -
> -static void free_all_tasks(void)
> -{
> -	/* make sure we don't leak task structs */
> -	process_task_mortuary();
> -	process_task_mortuary();
> -}
> -
> -int sync_start(void)
> -{
> -	int err;
> -
> -	if (!zalloc_cpumask_var(&marked_cpus, GFP_KERNEL))
> -		return -ENOMEM;
> -
> -	err = task_handoff_register(&task_free_nb);
> -	if (err)
> -		goto out1;
> -	err = profile_event_register(PROFILE_TASK_EXIT, &task_exit_nb);
> -	if (err)
> -		goto out2;
> -	err = profile_event_register(PROFILE_MUNMAP, &munmap_nb);
> -	if (err)
> -		goto out3;
> -	err = register_module_notifier(&module_load_nb);
> -	if (err)
> -		goto out4;
> -
> -	start_cpu_work();
> -
> -out:
> -	return err;
> -out4:
> -	profile_event_unregister(PROFILE_MUNMAP, &munmap_nb);
> -out3:
> -	profile_event_unregister(PROFILE_TASK_EXIT, &task_exit_nb);
> -out2:
> -	task_handoff_unregister(&task_free_nb);
> -	free_all_tasks();
> -out1:
> -	free_cpumask_var(marked_cpus);
> -	goto out;
> -}
> -
> -
> -void sync_stop(void)
> -{
> -	end_cpu_work();
> -	unregister_module_notifier(&module_load_nb);
> -	profile_event_unregister(PROFILE_MUNMAP, &munmap_nb);
> -	profile_event_unregister(PROFILE_TASK_EXIT, &task_exit_nb);
> -	task_handoff_unregister(&task_free_nb);
> -	barrier();			/* do all of the above first */
> -
> -	flush_cpu_work();
> -
> -	free_all_tasks();
> -	free_cpumask_var(marked_cpus);
> -}
> -
> -
> -/* Optimisation. We can manage without taking the dcookie sem
> - * because we cannot reach this code without at least one
> - * dcookie user still being registered (namely, the reader
> - * of the event buffer). */
> -static inline unsigned long fast_get_dcookie(const struct path *path)
> -{
> -	unsigned long cookie;
> -
> -	if (path->dentry->d_flags & DCACHE_COOKIE)
> -		return (unsigned long)path->dentry;
> -	get_dcookie(path, &cookie);
> -	return cookie;
> -}
> -
> -
> -/* Look up the dcookie for the task's mm->exe_file,
> - * which corresponds loosely to "application name". This is
> - * not strictly necessary but allows oprofile to associate
> - * shared-library samples with particular applications
> - */
> -static unsigned long get_exec_dcookie(struct mm_struct *mm)
> -{
> -	unsigned long cookie = NO_COOKIE;
> -	struct file *exe_file;
> -
> -	if (!mm)
> -		goto done;
> -
> -	exe_file = get_mm_exe_file(mm);
> -	if (!exe_file)
> -		goto done;
> -
> -	cookie = fast_get_dcookie(&exe_file->f_path);
> -	fput(exe_file);
> -done:
> -	return cookie;
> -}
> -
> -
> -/* Convert the EIP value of a sample into a persistent dentry/offset
> - * pair that can then be added to the global event buffer. We make
> - * sure to do this lookup before a mm->mmap modification happens so
> - * we don't lose track.
> - *
> - * The caller must ensure the mm is not nil (ie: not a kernel thread).
> - */
> -static unsigned long
> -lookup_dcookie(struct mm_struct *mm, unsigned long addr, off_t *offset)
> -{
> -	unsigned long cookie = NO_COOKIE;
> -	struct vm_area_struct *vma;
> -
> -	mmap_read_lock(mm);
> -	for (vma = find_vma(mm, addr); vma; vma = vma->vm_next) {
> -
> -		if (addr < vma->vm_start || addr >= vma->vm_end)
> -			continue;
> -
> -		if (vma->vm_file) {
> -			cookie = fast_get_dcookie(&vma->vm_file->f_path);
> -			*offset = (vma->vm_pgoff << PAGE_SHIFT) + addr -
> -				vma->vm_start;
> -		} else {
> -			/* must be an anonymous map */
> -			*offset = addr;
> -		}
> -
> -		break;
> -	}
> -
> -	if (!vma)
> -		cookie = INVALID_COOKIE;
> -	mmap_read_unlock(mm);
> -
> -	return cookie;
> -}
> -
> -static unsigned long last_cookie = INVALID_COOKIE;
> -
> -static void add_cpu_switch(int i)
> -{
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(CPU_SWITCH_CODE);
> -	add_event_entry(i);
> -	last_cookie = INVALID_COOKIE;
> -}
> -
> -static void add_kernel_ctx_switch(unsigned int in_kernel)
> -{
> -	add_event_entry(ESCAPE_CODE);
> -	if (in_kernel)
> -		add_event_entry(KERNEL_ENTER_SWITCH_CODE);
> -	else
> -		add_event_entry(KERNEL_EXIT_SWITCH_CODE);
> -}
> -
> -static void
> -add_user_ctx_switch(struct task_struct const *task, unsigned long cookie)
> -{
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(CTX_SWITCH_CODE);
> -	add_event_entry(task->pid);
> -	add_event_entry(cookie);
> -	/* Another code for daemon back-compat */
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(CTX_TGID_CODE);
> -	add_event_entry(task->tgid);
> -}
> -
> -
> -static void add_cookie_switch(unsigned long cookie)
> -{
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(COOKIE_SWITCH_CODE);
> -	add_event_entry(cookie);
> -}
> -
> -
> -static void add_trace_begin(void)
> -{
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(TRACE_BEGIN_CODE);
> -}
> -
> -static void add_data(struct op_entry *entry, struct mm_struct *mm)
> -{
> -	unsigned long code, pc, val;
> -	unsigned long cookie;
> -	off_t offset;
> -
> -	if (!op_cpu_buffer_get_data(entry, &code))
> -		return;
> -	if (!op_cpu_buffer_get_data(entry, &pc))
> -		return;
> -	if (!op_cpu_buffer_get_size(entry))
> -		return;
> -
> -	if (mm) {
> -		cookie = lookup_dcookie(mm, pc, &offset);
> -
> -		if (cookie == NO_COOKIE)
> -			offset = pc;
> -		if (cookie == INVALID_COOKIE) {
> -			atomic_inc(&oprofile_stats.sample_lost_no_mapping);
> -			offset = pc;
> -		}
> -		if (cookie != last_cookie) {
> -			add_cookie_switch(cookie);
> -			last_cookie = cookie;
> -		}
> -	} else
> -		offset = pc;
> -
> -	add_event_entry(ESCAPE_CODE);
> -	add_event_entry(code);
> -	add_event_entry(offset);	/* Offset from Dcookie */
> -
> -	while (op_cpu_buffer_get_data(entry, &val))
> -		add_event_entry(val);
> -}
> -
> -static inline void add_sample_entry(unsigned long offset, unsigned long event)
> -{
> -	add_event_entry(offset);
> -	add_event_entry(event);
> -}
> -
> -
> -/*
> - * Add a sample to the global event buffer. If possible the
> - * sample is converted into a persistent dentry/offset pair
> - * for later lookup from userspace. Return 0 on failure.
> - */
> -static int
> -add_sample(struct mm_struct *mm, struct op_sample *s, int in_kernel)
> -{
> -	unsigned long cookie;
> -	off_t offset;
> -
> -	if (in_kernel) {
> -		add_sample_entry(s->eip, s->event);
> -		return 1;
> -	}
> -
> -	/* add userspace sample */
> -
> -	if (!mm) {
> -		atomic_inc(&oprofile_stats.sample_lost_no_mm);
> -		return 0;
> -	}
> -
> -	cookie = lookup_dcookie(mm, s->eip, &offset);
> -
> -	if (cookie == INVALID_COOKIE) {
> -		atomic_inc(&oprofile_stats.sample_lost_no_mapping);
> -		return 0;
> -	}
> -
> -	if (cookie != last_cookie) {
> -		add_cookie_switch(cookie);
> -		last_cookie = cookie;
> -	}
> -
> -	add_sample_entry(offset, s->event);
> -
> -	return 1;
> -}
> -
> -
> -static void release_mm(struct mm_struct *mm)
> -{
> -	if (!mm)
> -		return;
> -	mmput(mm);
> -}
> -
> -static inline int is_code(unsigned long val)
> -{
> -	return val == ESCAPE_CODE;
> -}
> -
> -
> -/* Move tasks along towards death. Any tasks on dead_tasks
> - * will definitely have no remaining references in any
> - * CPU buffers at this point, because we use two lists,
> - * and to have reached the list, it must have gone through
> - * one full sync already.
> - */
> -static void process_task_mortuary(void)
> -{
> -	unsigned long flags;
> -	LIST_HEAD(local_dead_tasks);
> -	struct task_struct *task;
> -	struct task_struct *ttask;
> -
> -	spin_lock_irqsave(&task_mortuary, flags);
> -
> -	list_splice_init(&dead_tasks, &local_dead_tasks);
> -	list_splice_init(&dying_tasks, &dead_tasks);
> -
> -	spin_unlock_irqrestore(&task_mortuary, flags);
> -
> -	list_for_each_entry_safe(task, ttask, &local_dead_tasks, tasks) {
> -		list_del(&task->tasks);
> -		free_task(task);
> -	}
> -}
> -
> -
> -static void mark_done(int cpu)
> -{
> -	int i;
> -
> -	cpumask_set_cpu(cpu, marked_cpus);
> -
> -	for_each_online_cpu(i) {
> -		if (!cpumask_test_cpu(i, marked_cpus))
> -			return;
> -	}
> -
> -	/* All CPUs have been processed at least once,
> -	 * we can process the mortuary once
> -	 */
> -	process_task_mortuary();
> -
> -	cpumask_clear(marked_cpus);
> -}
> -
> -
> -/* FIXME: this is not sufficient if we implement syscall barrier backtrace
> - * traversal, the code switch to sb_sample_start at first kernel enter/exit
> - * switch so we need a fifth state and some special handling in sync_buffer()
> - */
> -typedef enum {
> -	sb_bt_ignore = -2,
> -	sb_buffer_start,
> -	sb_bt_start,
> -	sb_sample_start,
> -} sync_buffer_state;
> -
> -/* Sync one of the CPU's buffers into the global event buffer.
> - * Here we need to go through each batch of samples punctuated
> - * by context switch notes, taking the task's mmap_lock and doing
> - * lookup in task->mm->mmap to convert EIP into dcookie/offset
> - * value.
> - */
> -void sync_buffer(int cpu)
> -{
> -	struct mm_struct *mm = NULL;
> -	struct mm_struct *oldmm;
> -	unsigned long val;
> -	struct task_struct *new;
> -	unsigned long cookie = 0;
> -	int in_kernel = 1;
> -	sync_buffer_state state = sb_buffer_start;
> -	unsigned int i;
> -	unsigned long available;
> -	unsigned long flags;
> -	struct op_entry entry;
> -	struct op_sample *sample;
> -
> -	mutex_lock(&buffer_mutex);
> -
> -	add_cpu_switch(cpu);
> -
> -	op_cpu_buffer_reset(cpu);
> -	available = op_cpu_buffer_entries(cpu);
> -
> -	for (i = 0; i < available; ++i) {
> -		sample = op_cpu_buffer_read_entry(&entry, cpu);
> -		if (!sample)
> -			break;
> -
> -		if (is_code(sample->eip)) {
> -			flags = sample->event;
> -			if (flags & TRACE_BEGIN) {
> -				state = sb_bt_start;
> -				add_trace_begin();
> -			}
> -			if (flags & KERNEL_CTX_SWITCH) {
> -				/* kernel/userspace switch */
> -				in_kernel = flags & IS_KERNEL;
> -				if (state == sb_buffer_start)
> -					state = sb_sample_start;
> -				add_kernel_ctx_switch(flags & IS_KERNEL);
> -			}
> -			if (flags & USER_CTX_SWITCH
> -			    && op_cpu_buffer_get_data(&entry, &val)) {
> -				/* userspace context switch */
> -				new = (struct task_struct *)val;
> -				oldmm = mm;
> -				release_mm(oldmm);
> -				mm = get_task_mm(new);
> -				if (mm != oldmm)
> -					cookie = get_exec_dcookie(mm);
> -				add_user_ctx_switch(new, cookie);
> -			}
> -			if (op_cpu_buffer_get_size(&entry))
> -				add_data(&entry, mm);
> -			continue;
> -		}
> -
> -		if (state < sb_bt_start)
> -			/* ignore sample */
> -			continue;
> -
> -		if (add_sample(mm, sample, in_kernel))
> -			continue;
> -
> -		/* ignore backtraces if failed to add a sample */
> -		if (state == sb_bt_start) {
> -			state = sb_bt_ignore;
> -			atomic_inc(&oprofile_stats.bt_lost_no_mapping);
> -		}
> -	}
> -	release_mm(mm);
> -
> -	mark_done(cpu);
> -
> -	mutex_unlock(&buffer_mutex);
> -}
> -
> -/* The function can be used to add a buffer worth of data directly to
> - * the kernel buffer. The buffer is assumed to be a circular buffer.
> - * Take the entries from index start and end at index end, wrapping
> - * at max_entries.
> - */
> -void oprofile_put_buff(unsigned long *buf, unsigned int start,
> -		       unsigned int stop, unsigned int max)
> -{
> -	int i;
> -
> -	i = start;
> -
> -	mutex_lock(&buffer_mutex);
> -	while (i != stop) {
> -		add_event_entry(buf[i++]);
> -
> -		if (i >= max)
> -			i = 0;
> -	}
> -
> -	mutex_unlock(&buffer_mutex);
> -}
> -
> diff --git a/drivers/oprofile/buffer_sync.h b/drivers/oprofile/buffer_sync.h
> deleted file mode 100644
> index 3110732c1835..000000000000
> --- a/drivers/oprofile/buffer_sync.h
> +++ /dev/null
> @@ -1,22 +0,0 @@
> -/**
> - * @file buffer_sync.h
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - */
> -
> -#ifndef OPROFILE_BUFFER_SYNC_H
> -#define OPROFILE_BUFFER_SYNC_H
> -
> -/* add the necessary profiling hooks */
> -int sync_start(void);
> -
> -/* remove the hooks */
> -void sync_stop(void);
> -
> -/* sync the given CPU's buffer */
> -void sync_buffer(int cpu);
> -
> -#endif /* OPROFILE_BUFFER_SYNC_H */
> diff --git a/drivers/oprofile/cpu_buffer.c b/drivers/oprofile/cpu_buffer.c
> deleted file mode 100644
> index 9210a95cb4e6..000000000000
> --- a/drivers/oprofile/cpu_buffer.c
> +++ /dev/null
> @@ -1,465 +0,0 @@
> -/**
> - * @file cpu_buffer.c
> - *
> - * @remark Copyright 2002-2009 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - * @author Barry Kasindorf <barry.kasindorf@amd.com>
> - * @author Robert Richter <robert.richter@amd.com>
> - *
> - * Each CPU has a local buffer that stores PC value/event
> - * pairs. We also log context switches when we notice them.
> - * Eventually each CPU's buffer is processed into the global
> - * event buffer by sync_buffer().
> - *
> - * We use a local buffer for two reasons: an NMI or similar
> - * interrupt cannot synchronise, and high sampling rates
> - * would lead to catastrophic global synchronisation if
> - * a global buffer was used.
> - */
> -
> -#include <linux/sched.h>
> -#include <linux/oprofile.h>
> -#include <linux/errno.h>
> -
> -#include <asm/ptrace.h>
> -
> -#include "event_buffer.h"
> -#include "cpu_buffer.h"
> -#include "buffer_sync.h"
> -#include "oprof.h"
> -
> -#define OP_BUFFER_FLAGS	0
> -
> -static struct trace_buffer *op_ring_buffer;
> -DEFINE_PER_CPU(struct oprofile_cpu_buffer, op_cpu_buffer);
> -
> -static void wq_sync_buffer(struct work_struct *work);
> -
> -#define DEFAULT_TIMER_EXPIRE (HZ / 10)
> -static int work_enabled;
> -
> -unsigned long oprofile_get_cpu_buffer_size(void)
> -{
> -	return oprofile_cpu_buffer_size;
> -}
> -
> -void oprofile_cpu_buffer_inc_smpl_lost(void)
> -{
> -	struct oprofile_cpu_buffer *cpu_buf = this_cpu_ptr(&op_cpu_buffer);
> -
> -	cpu_buf->sample_lost_overflow++;
> -}
> -
> -void free_cpu_buffers(void)
> -{
> -	if (op_ring_buffer)
> -		ring_buffer_free(op_ring_buffer);
> -	op_ring_buffer = NULL;
> -}
> -
> -#define RB_EVENT_HDR_SIZE 4
> -
> -int alloc_cpu_buffers(void)
> -{
> -	int i;
> -
> -	unsigned long buffer_size = oprofile_cpu_buffer_size;
> -	unsigned long byte_size = buffer_size * (sizeof(struct op_sample) +
> -						 RB_EVENT_HDR_SIZE);
> -
> -	op_ring_buffer = ring_buffer_alloc(byte_size, OP_BUFFER_FLAGS);
> -	if (!op_ring_buffer)
> -		goto fail;
> -
> -	for_each_possible_cpu(i) {
> -		struct oprofile_cpu_buffer *b = &per_cpu(op_cpu_buffer, i);
> -
> -		b->last_task = NULL;
> -		b->last_is_kernel = -1;
> -		b->tracing = 0;
> -		b->buffer_size = buffer_size;
> -		b->sample_received = 0;
> -		b->sample_lost_overflow = 0;
> -		b->backtrace_aborted = 0;
> -		b->sample_invalid_eip = 0;
> -		b->cpu = i;
> -		INIT_DELAYED_WORK(&b->work, wq_sync_buffer);
> -	}
> -	return 0;
> -
> -fail:
> -	free_cpu_buffers();
> -	return -ENOMEM;
> -}
> -
> -void start_cpu_work(void)
> -{
> -	int i;
> -
> -	work_enabled = 1;
> -
> -	for_each_online_cpu(i) {
> -		struct oprofile_cpu_buffer *b = &per_cpu(op_cpu_buffer, i);
> -
> -		/*
> -		 * Spread the work by 1 jiffy per cpu so they dont all
> -		 * fire at once.
> -		 */
> -		schedule_delayed_work_on(i, &b->work, DEFAULT_TIMER_EXPIRE + i);
> -	}
> -}
> -
> -void end_cpu_work(void)
> -{
> -	work_enabled = 0;
> -}
> -
> -void flush_cpu_work(void)
> -{
> -	int i;
> -
> -	for_each_online_cpu(i) {
> -		struct oprofile_cpu_buffer *b = &per_cpu(op_cpu_buffer, i);
> -
> -		/* these works are per-cpu, no need for flush_sync */
> -		flush_delayed_work(&b->work);
> -	}
> -}
> -
> -/*
> - * This function prepares the cpu buffer to write a sample.
> - *
> - * Struct op_entry is used during operations on the ring buffer while
> - * struct op_sample contains the data that is stored in the ring
> - * buffer. Struct entry can be uninitialized. The function reserves a
> - * data array that is specified by size. Use
> - * op_cpu_buffer_write_commit() after preparing the sample. In case of
> - * errors a null pointer is returned, otherwise the pointer to the
> - * sample.
> - *
> - */
> -struct op_sample
> -*op_cpu_buffer_write_reserve(struct op_entry *entry, unsigned long size)
> -{
> -	entry->event = ring_buffer_lock_reserve
> -		(op_ring_buffer, sizeof(struct op_sample) +
> -		 size * sizeof(entry->sample->data[0]));
> -	if (!entry->event)
> -		return NULL;
> -	entry->sample = ring_buffer_event_data(entry->event);
> -	entry->size = size;
> -	entry->data = entry->sample->data;
> -
> -	return entry->sample;
> -}
> -
> -int op_cpu_buffer_write_commit(struct op_entry *entry)
> -{
> -	return ring_buffer_unlock_commit(op_ring_buffer, entry->event);
> -}
> -
> -struct op_sample *op_cpu_buffer_read_entry(struct op_entry *entry, int cpu)
> -{
> -	struct ring_buffer_event *e;
> -	e = ring_buffer_consume(op_ring_buffer, cpu, NULL, NULL);
> -	if (!e)
> -		return NULL;
> -
> -	entry->event = e;
> -	entry->sample = ring_buffer_event_data(e);
> -	entry->size = (ring_buffer_event_length(e) - sizeof(struct op_sample))
> -		/ sizeof(entry->sample->data[0]);
> -	entry->data = entry->sample->data;
> -	return entry->sample;
> -}
> -
> -unsigned long op_cpu_buffer_entries(int cpu)
> -{
> -	return ring_buffer_entries_cpu(op_ring_buffer, cpu);
> -}
> -
> -static int
> -op_add_code(struct oprofile_cpu_buffer *cpu_buf, unsigned long backtrace,
> -	    int is_kernel, struct task_struct *task)
> -{
> -	struct op_entry entry;
> -	struct op_sample *sample;
> -	unsigned long flags;
> -	int size;
> -
> -	flags = 0;
> -
> -	if (backtrace)
> -		flags |= TRACE_BEGIN;
> -
> -	/* notice a switch from user->kernel or vice versa */
> -	is_kernel = !!is_kernel;
> -	if (cpu_buf->last_is_kernel != is_kernel) {
> -		cpu_buf->last_is_kernel = is_kernel;
> -		flags |= KERNEL_CTX_SWITCH;
> -		if (is_kernel)
> -			flags |= IS_KERNEL;
> -	}
> -
> -	/* notice a task switch */
> -	if (cpu_buf->last_task != task) {
> -		cpu_buf->last_task = task;
> -		flags |= USER_CTX_SWITCH;
> -	}
> -
> -	if (!flags)
> -		/* nothing to do */
> -		return 0;
> -
> -	if (flags & USER_CTX_SWITCH)
> -		size = 1;
> -	else
> -		size = 0;
> -
> -	sample = op_cpu_buffer_write_reserve(&entry, size);
> -	if (!sample)
> -		return -ENOMEM;
> -
> -	sample->eip = ESCAPE_CODE;
> -	sample->event = flags;
> -
> -	if (size)
> -		op_cpu_buffer_add_data(&entry, (unsigned long)task);
> -
> -	op_cpu_buffer_write_commit(&entry);
> -
> -	return 0;
> -}
> -
> -static inline int
> -op_add_sample(struct oprofile_cpu_buffer *cpu_buf,
> -	      unsigned long pc, unsigned long event)
> -{
> -	struct op_entry entry;
> -	struct op_sample *sample;
> -
> -	sample = op_cpu_buffer_write_reserve(&entry, 0);
> -	if (!sample)
> -		return -ENOMEM;
> -
> -	sample->eip = pc;
> -	sample->event = event;
> -
> -	return op_cpu_buffer_write_commit(&entry);
> -}
> -
> -/*
> - * This must be safe from any context.
> - *
> - * is_kernel is needed because on some architectures you cannot
> - * tell if you are in kernel or user space simply by looking at
> - * pc. We tag this in the buffer by generating kernel enter/exit
> - * events whenever is_kernel changes
> - */
> -static int
> -log_sample(struct oprofile_cpu_buffer *cpu_buf, unsigned long pc,
> -	   unsigned long backtrace, int is_kernel, unsigned long event,
> -	   struct task_struct *task)
> -{
> -	struct task_struct *tsk = task ? task : current;
> -	cpu_buf->sample_received++;
> -
> -	if (pc == ESCAPE_CODE) {
> -		cpu_buf->sample_invalid_eip++;
> -		return 0;
> -	}
> -
> -	if (op_add_code(cpu_buf, backtrace, is_kernel, tsk))
> -		goto fail;
> -
> -	if (op_add_sample(cpu_buf, pc, event))
> -		goto fail;
> -
> -	return 1;
> -
> -fail:
> -	cpu_buf->sample_lost_overflow++;
> -	return 0;
> -}
> -
> -static inline void oprofile_begin_trace(struct oprofile_cpu_buffer *cpu_buf)
> -{
> -	cpu_buf->tracing = 1;
> -}
> -
> -static inline void oprofile_end_trace(struct oprofile_cpu_buffer *cpu_buf)
> -{
> -	cpu_buf->tracing = 0;
> -}
> -
> -static inline void
> -__oprofile_add_ext_sample(unsigned long pc, struct pt_regs * const regs,
> -			  unsigned long event, int is_kernel,
> -			  struct task_struct *task)
> -{
> -	struct oprofile_cpu_buffer *cpu_buf = this_cpu_ptr(&op_cpu_buffer);
> -	unsigned long backtrace = oprofile_backtrace_depth;
> -
> -	/*
> -	 * if log_sample() fail we can't backtrace since we lost the
> -	 * source of this event
> -	 */
> -	if (!log_sample(cpu_buf, pc, backtrace, is_kernel, event, task))
> -		/* failed */
> -		return;
> -
> -	if (!backtrace)
> -		return;
> -
> -	oprofile_begin_trace(cpu_buf);
> -	oprofile_ops.backtrace(regs, backtrace);
> -	oprofile_end_trace(cpu_buf);
> -}
> -
> -void oprofile_add_ext_hw_sample(unsigned long pc, struct pt_regs * const regs,
> -				unsigned long event, int is_kernel,
> -				struct task_struct *task)
> -{
> -	__oprofile_add_ext_sample(pc, regs, event, is_kernel, task);
> -}
> -
> -void oprofile_add_ext_sample(unsigned long pc, struct pt_regs * const regs,
> -			     unsigned long event, int is_kernel)
> -{
> -	__oprofile_add_ext_sample(pc, regs, event, is_kernel, NULL);
> -}
> -
> -void oprofile_add_sample(struct pt_regs * const regs, unsigned long event)
> -{
> -	int is_kernel;
> -	unsigned long pc;
> -
> -	if (likely(regs)) {
> -		is_kernel = !user_mode(regs);
> -		pc = profile_pc(regs);
> -	} else {
> -		is_kernel = 0;    /* This value will not be used */
> -		pc = ESCAPE_CODE; /* as this causes an early return. */
> -	}
> -
> -	__oprofile_add_ext_sample(pc, regs, event, is_kernel, NULL);
> -}
> -
> -/*
> - * Add samples with data to the ring buffer.
> - *
> - * Use oprofile_add_data(&entry, val) to add data and
> - * oprofile_write_commit(&entry) to commit the sample.
> - */
> -void
> -oprofile_write_reserve(struct op_entry *entry, struct pt_regs * const regs,
> -		       unsigned long pc, int code, int size)
> -{
> -	struct op_sample *sample;
> -	int is_kernel = !user_mode(regs);
> -	struct oprofile_cpu_buffer *cpu_buf = this_cpu_ptr(&op_cpu_buffer);
> -
> -	cpu_buf->sample_received++;
> -
> -	/* no backtraces for samples with data */
> -	if (op_add_code(cpu_buf, 0, is_kernel, current))
> -		goto fail;
> -
> -	sample = op_cpu_buffer_write_reserve(entry, size + 2);
> -	if (!sample)
> -		goto fail;
> -	sample->eip = ESCAPE_CODE;
> -	sample->event = 0;		/* no flags */
> -
> -	op_cpu_buffer_add_data(entry, code);
> -	op_cpu_buffer_add_data(entry, pc);
> -
> -	return;
> -
> -fail:
> -	entry->event = NULL;
> -	cpu_buf->sample_lost_overflow++;
> -}
> -
> -int oprofile_add_data(struct op_entry *entry, unsigned long val)
> -{
> -	if (!entry->event)
> -		return 0;
> -	return op_cpu_buffer_add_data(entry, val);
> -}
> -
> -int oprofile_add_data64(struct op_entry *entry, u64 val)
> -{
> -	if (!entry->event)
> -		return 0;
> -	if (op_cpu_buffer_get_size(entry) < 2)
> -		/*
> -		 * the function returns 0 to indicate a too small
> -		 * buffer, even if there is some space left
> -		 */
> -		return 0;
> -	if (!op_cpu_buffer_add_data(entry, (u32)val))
> -		return 0;
> -	return op_cpu_buffer_add_data(entry, (u32)(val >> 32));
> -}
> -
> -int oprofile_write_commit(struct op_entry *entry)
> -{
> -	if (!entry->event)
> -		return -EINVAL;
> -	return op_cpu_buffer_write_commit(entry);
> -}
> -
> -void oprofile_add_pc(unsigned long pc, int is_kernel, unsigned long event)
> -{
> -	struct oprofile_cpu_buffer *cpu_buf = this_cpu_ptr(&op_cpu_buffer);
> -	log_sample(cpu_buf, pc, 0, is_kernel, event, NULL);
> -}
> -
> -void oprofile_add_trace(unsigned long pc)
> -{
> -	struct oprofile_cpu_buffer *cpu_buf = this_cpu_ptr(&op_cpu_buffer);
> -
> -	if (!cpu_buf->tracing)
> -		return;
> -
> -	/*
> -	 * broken frame can give an eip with the same value as an
> -	 * escape code, abort the trace if we get it
> -	 */
> -	if (pc == ESCAPE_CODE)
> -		goto fail;
> -
> -	if (op_add_sample(cpu_buf, pc, 0))
> -		goto fail;
> -
> -	return;
> -fail:
> -	cpu_buf->tracing = 0;
> -	cpu_buf->backtrace_aborted++;
> -	return;
> -}
> -
> -/*
> - * This serves to avoid cpu buffer overflow, and makes sure
> - * the task mortuary progresses
> - *
> - * By using schedule_delayed_work_on and then schedule_delayed_work
> - * we guarantee this will stay on the correct cpu
> - */
> -static void wq_sync_buffer(struct work_struct *work)
> -{
> -	struct oprofile_cpu_buffer *b =
> -		container_of(work, struct oprofile_cpu_buffer, work.work);
> -	if (b->cpu != smp_processor_id() && !cpu_online(b->cpu)) {
> -		cancel_delayed_work(&b->work);
> -		return;
> -	}
> -	sync_buffer(b->cpu);
> -
> -	/* don't re-add the work if we're shutting down */
> -	if (work_enabled)
> -		schedule_delayed_work(&b->work, DEFAULT_TIMER_EXPIRE);
> -}
> diff --git a/drivers/oprofile/cpu_buffer.h b/drivers/oprofile/cpu_buffer.h
> deleted file mode 100644
> index 31478c0cff87..000000000000
> --- a/drivers/oprofile/cpu_buffer.h
> +++ /dev/null
> @@ -1,121 +0,0 @@
> -/**
> - * @file cpu_buffer.h
> - *
> - * @remark Copyright 2002-2009 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - * @author Robert Richter <robert.richter@amd.com>
> - */
> -
> -#ifndef OPROFILE_CPU_BUFFER_H
> -#define OPROFILE_CPU_BUFFER_H
> -
> -#include <linux/types.h>
> -#include <linux/spinlock.h>
> -#include <linux/workqueue.h>
> -#include <linux/cache.h>
> -#include <linux/sched.h>
> -#include <linux/ring_buffer.h>
> -
> -struct task_struct;
> -
> -int alloc_cpu_buffers(void);
> -void free_cpu_buffers(void);
> -
> -void start_cpu_work(void);
> -void end_cpu_work(void);
> -void flush_cpu_work(void);
> -
> -/* CPU buffer is composed of such entries (which are
> - * also used for context switch notes)
> - */
> -struct op_sample {
> -	unsigned long eip;
> -	unsigned long event;
> -	unsigned long data[];
> -};
> -
> -struct op_entry;
> -
> -struct oprofile_cpu_buffer {
> -	unsigned long buffer_size;
> -	struct task_struct *last_task;
> -	int last_is_kernel;
> -	int tracing;
> -	unsigned long sample_received;
> -	unsigned long sample_lost_overflow;
> -	unsigned long backtrace_aborted;
> -	unsigned long sample_invalid_eip;
> -	int cpu;
> -	struct delayed_work work;
> -};
> -
> -DECLARE_PER_CPU(struct oprofile_cpu_buffer, op_cpu_buffer);
> -
> -/*
> - * Resets the cpu buffer to a sane state.
> - *
> - * reset these to invalid values; the next sample collected will
> - * populate the buffer with proper values to initialize the buffer
> - */
> -static inline void op_cpu_buffer_reset(int cpu)
> -{
> -	struct oprofile_cpu_buffer *cpu_buf = &per_cpu(op_cpu_buffer, cpu);
> -
> -	cpu_buf->last_is_kernel = -1;
> -	cpu_buf->last_task = NULL;
> -}
> -
> -/*
> - * op_cpu_buffer_add_data() and op_cpu_buffer_write_commit() may be
> - * called only if op_cpu_buffer_write_reserve() did not return NULL or
> - * entry->event != NULL, otherwise entry->size or entry->event will be
> - * used uninitialized.
> - */
> -
> -struct op_sample
> -*op_cpu_buffer_write_reserve(struct op_entry *entry, unsigned long size);
> -int op_cpu_buffer_write_commit(struct op_entry *entry);
> -struct op_sample *op_cpu_buffer_read_entry(struct op_entry *entry, int cpu);
> -unsigned long op_cpu_buffer_entries(int cpu);
> -
> -/* returns the remaining free size of data in the entry */
> -static inline
> -int op_cpu_buffer_add_data(struct op_entry *entry, unsigned long val)
> -{
> -	if (!entry->size)
> -		return 0;
> -	*entry->data = val;
> -	entry->size--;
> -	entry->data++;
> -	return entry->size;
> -}
> -
> -/* returns the size of data in the entry */
> -static inline
> -int op_cpu_buffer_get_size(struct op_entry *entry)
> -{
> -	return entry->size;
> -}
> -
> -/* returns 0 if empty or the size of data including the current value */
> -static inline
> -int op_cpu_buffer_get_data(struct op_entry *entry, unsigned long *val)
> -{
> -	int size = entry->size;
> -	if (!size)
> -		return 0;
> -	*val = *entry->data;
> -	entry->size--;
> -	entry->data++;
> -	return size;
> -}
> -
> -/* extra data flags */
> -#define KERNEL_CTX_SWITCH	(1UL << 0)
> -#define IS_KERNEL		(1UL << 1)
> -#define TRACE_BEGIN		(1UL << 2)
> -#define USER_CTX_SWITCH		(1UL << 3)
> -
> -#endif /* OPROFILE_CPU_BUFFER_H */
> diff --git a/drivers/oprofile/event_buffer.c b/drivers/oprofile/event_buffer.c
> deleted file mode 100644
> index 6c9edc8bbc95..000000000000
> --- a/drivers/oprofile/event_buffer.c
> +++ /dev/null
> @@ -1,209 +0,0 @@
> -/**
> - * @file event_buffer.c
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - *
> - * This is the global event buffer that the user-space
> - * daemon reads from. The event buffer is an untyped array
> - * of unsigned longs. Entries are prefixed by the
> - * escape value ESCAPE_CODE followed by an identifying code.
> - */
> -
> -#include <linux/vmalloc.h>
> -#include <linux/oprofile.h>
> -#include <linux/sched/signal.h>
> -#include <linux/capability.h>
> -#include <linux/dcookies.h>
> -#include <linux/fs.h>
> -#include <linux/uaccess.h>
> -
> -#include "oprof.h"
> -#include "event_buffer.h"
> -#include "oprofile_stats.h"
> -
> -DEFINE_MUTEX(buffer_mutex);
> -
> -static unsigned long buffer_opened;
> -static DECLARE_WAIT_QUEUE_HEAD(buffer_wait);
> -static unsigned long *event_buffer;
> -static unsigned long buffer_size;
> -static unsigned long buffer_watershed;
> -static size_t buffer_pos;
> -/* atomic_t because wait_event checks it outside of buffer_mutex */
> -static atomic_t buffer_ready = ATOMIC_INIT(0);
> -
> -/*
> - * Add an entry to the event buffer. When we get near to the end we
> - * wake up the process sleeping on the read() of the file. To protect
> - * the event_buffer this function may only be called when buffer_mutex
> - * is set.
> - */
> -void add_event_entry(unsigned long value)
> -{
> -	/*
> -	 * This shouldn't happen since all workqueues or handlers are
> -	 * canceled or flushed before the event buffer is freed.
> -	 */
> -	if (!event_buffer) {
> -		WARN_ON_ONCE(1);
> -		return;
> -	}
> -
> -	if (buffer_pos == buffer_size) {
> -		atomic_inc(&oprofile_stats.event_lost_overflow);
> -		return;
> -	}
> -
> -	event_buffer[buffer_pos] = value;
> -	if (++buffer_pos == buffer_size - buffer_watershed) {
> -		atomic_set(&buffer_ready, 1);
> -		wake_up(&buffer_wait);
> -	}
> -}
> -
> -
> -/* Wake up the waiting process if any. This happens
> - * on "echo 0 >/dev/oprofile/enable" so the daemon
> - * processes the data remaining in the event buffer.
> - */
> -void wake_up_buffer_waiter(void)
> -{
> -	mutex_lock(&buffer_mutex);
> -	atomic_set(&buffer_ready, 1);
> -	wake_up(&buffer_wait);
> -	mutex_unlock(&buffer_mutex);
> -}
> -
> -
> -int alloc_event_buffer(void)
> -{
> -	unsigned long flags;
> -
> -	raw_spin_lock_irqsave(&oprofilefs_lock, flags);
> -	buffer_size = oprofile_buffer_size;
> -	buffer_watershed = oprofile_buffer_watershed;
> -	raw_spin_unlock_irqrestore(&oprofilefs_lock, flags);
> -
> -	if (buffer_watershed >= buffer_size)
> -		return -EINVAL;
> -
> -	buffer_pos = 0;
> -	event_buffer = vmalloc(array_size(buffer_size, sizeof(unsigned long)));
> -	if (!event_buffer)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
> -
> -void free_event_buffer(void)
> -{
> -	mutex_lock(&buffer_mutex);
> -	vfree(event_buffer);
> -	buffer_pos = 0;
> -	event_buffer = NULL;
> -	mutex_unlock(&buffer_mutex);
> -}
> -
> -
> -static int event_buffer_open(struct inode *inode, struct file *file)
> -{
> -	int err = -EPERM;
> -
> -	if (!perfmon_capable())
> -		return -EPERM;
> -
> -	if (test_and_set_bit_lock(0, &buffer_opened))
> -		return -EBUSY;
> -
> -	/* Register as a user of dcookies
> -	 * to ensure they persist for the lifetime of
> -	 * the open event file
> -	 */
> -	err = -EINVAL;
> -	file->private_data = dcookie_register();
> -	if (!file->private_data)
> -		goto out;
> -
> -	if ((err = oprofile_setup()))
> -		goto fail;
> -
> -	/* NB: the actual start happens from userspace
> -	 * echo 1 >/dev/oprofile/enable
> -	 */
> -
> -	return nonseekable_open(inode, file);
> -
> -fail:
> -	dcookie_unregister(file->private_data);
> -out:
> -	__clear_bit_unlock(0, &buffer_opened);
> -	return err;
> -}
> -
> -
> -static int event_buffer_release(struct inode *inode, struct file *file)
> -{
> -	oprofile_stop();
> -	oprofile_shutdown();
> -	dcookie_unregister(file->private_data);
> -	buffer_pos = 0;
> -	atomic_set(&buffer_ready, 0);
> -	__clear_bit_unlock(0, &buffer_opened);
> -	return 0;
> -}
> -
> -
> -static ssize_t event_buffer_read(struct file *file, char __user *buf,
> -				 size_t count, loff_t *offset)
> -{
> -	int retval = -EINVAL;
> -	size_t const max = buffer_size * sizeof(unsigned long);
> -
> -	/* handling partial reads is more trouble than it's worth */
> -	if (count != max || *offset)
> -		return -EINVAL;
> -
> -	wait_event_interruptible(buffer_wait, atomic_read(&buffer_ready));
> -
> -	if (signal_pending(current))
> -		return -EINTR;
> -
> -	/* can't currently happen */
> -	if (!atomic_read(&buffer_ready))
> -		return -EAGAIN;
> -
> -	mutex_lock(&buffer_mutex);
> -
> -	/* May happen if the buffer is freed during pending reads. */
> -	if (!event_buffer) {
> -		retval = -EINTR;
> -		goto out;
> -	}
> -
> -	atomic_set(&buffer_ready, 0);
> -
> -	retval = -EFAULT;
> -
> -	count = buffer_pos * sizeof(unsigned long);
> -
> -	if (copy_to_user(buf, event_buffer, count))
> -		goto out;
> -
> -	retval = count;
> -	buffer_pos = 0;
> -
> -out:
> -	mutex_unlock(&buffer_mutex);
> -	return retval;
> -}
> -
> -const struct file_operations event_buffer_fops = {
> -	.open		= event_buffer_open,
> -	.release	= event_buffer_release,
> -	.read		= event_buffer_read,
> -	.llseek		= no_llseek,
> -};
> diff --git a/drivers/oprofile/event_buffer.h b/drivers/oprofile/event_buffer.h
> deleted file mode 100644
> index a8d5bb3cba89..000000000000
> --- a/drivers/oprofile/event_buffer.h
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -/**
> - * @file event_buffer.h
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - */
> -
> -#ifndef EVENT_BUFFER_H
> -#define EVENT_BUFFER_H
> -
> -#include <linux/types.h>
> -#include <linux/mutex.h>
> -
> -int alloc_event_buffer(void);
> -
> -void free_event_buffer(void);
> -
> -/**
> - * Add data to the event buffer.
> - * The data passed is free-form, but typically consists of
> - * file offsets, dcookies, context information, and ESCAPE codes.
> - */
> -void add_event_entry(unsigned long data);
> -
> -/* wake up the process sleeping on the event file */
> -void wake_up_buffer_waiter(void);
> -
> -#define INVALID_COOKIE ~0UL
> -#define NO_COOKIE 0UL
> -
> -extern const struct file_operations event_buffer_fops;
> -
> -/* mutex between sync_cpu_buffers() and the
> - * file reading code.
> - */
> -extern struct mutex buffer_mutex;
> -
> -#endif /* EVENT_BUFFER_H */
> diff --git a/drivers/oprofile/nmi_timer_int.c b/drivers/oprofile/nmi_timer_int.c
> deleted file mode 100644
> index f343bd96609a..000000000000
> --- a/drivers/oprofile/nmi_timer_int.c
> +++ /dev/null
> @@ -1,157 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/**
> - * @file nmi_timer_int.c
> - *
> - * @remark Copyright 2011 Advanced Micro Devices, Inc.
> - *
> - * @author Robert Richter <robert.richter@amd.com>
> - */
> -
> -#include <linux/init.h>
> -#include <linux/smp.h>
> -#include <linux/errno.h>
> -#include <linux/oprofile.h>
> -#include <linux/perf_event.h>
> -
> -#ifdef CONFIG_OPROFILE_NMI_TIMER
> -
> -static DEFINE_PER_CPU(struct perf_event *, nmi_timer_events);
> -static int ctr_running;
> -
> -static struct perf_event_attr nmi_timer_attr = {
> -	.type           = PERF_TYPE_HARDWARE,
> -	.config         = PERF_COUNT_HW_CPU_CYCLES,
> -	.size           = sizeof(struct perf_event_attr),
> -	.pinned         = 1,
> -	.disabled       = 1,
> -};
> -
> -static void nmi_timer_callback(struct perf_event *event,
> -			       struct perf_sample_data *data,
> -			       struct pt_regs *regs)
> -{
> -	event->hw.interrupts = 0;       /* don't throttle interrupts */
> -	oprofile_add_sample(regs, 0);
> -}
> -
> -static int nmi_timer_start_cpu(int cpu)
> -{
> -	struct perf_event *event = per_cpu(nmi_timer_events, cpu);
> -
> -	if (!event) {
> -		event = perf_event_create_kernel_counter(&nmi_timer_attr, cpu, NULL,
> -							 nmi_timer_callback, NULL);
> -		if (IS_ERR(event))
> -			return PTR_ERR(event);
> -		per_cpu(nmi_timer_events, cpu) = event;
> -	}
> -
> -	if (event && ctr_running)
> -		perf_event_enable(event);
> -
> -	return 0;
> -}
> -
> -static void nmi_timer_stop_cpu(int cpu)
> -{
> -	struct perf_event *event = per_cpu(nmi_timer_events, cpu);
> -
> -	if (event && ctr_running)
> -		perf_event_disable(event);
> -}
> -
> -static int nmi_timer_cpu_online(unsigned int cpu)
> -{
> -	nmi_timer_start_cpu(cpu);
> -	return 0;
> -}
> -static int nmi_timer_cpu_predown(unsigned int cpu)
> -{
> -	nmi_timer_stop_cpu(cpu);
> -	return 0;
> -}
> -
> -static int nmi_timer_start(void)
> -{
> -	int cpu;
> -
> -	get_online_cpus();
> -	ctr_running = 1;
> -	for_each_online_cpu(cpu)
> -		nmi_timer_start_cpu(cpu);
> -	put_online_cpus();
> -
> -	return 0;
> -}
> -
> -static void nmi_timer_stop(void)
> -{
> -	int cpu;
> -
> -	get_online_cpus();
> -	for_each_online_cpu(cpu)
> -		nmi_timer_stop_cpu(cpu);
> -	ctr_running = 0;
> -	put_online_cpus();
> -}
> -
> -static enum cpuhp_state hp_online;
> -
> -static void nmi_timer_shutdown(void)
> -{
> -	struct perf_event *event;
> -	int cpu;
> -
> -	cpuhp_remove_state(hp_online);
> -	for_each_possible_cpu(cpu) {
> -		event = per_cpu(nmi_timer_events, cpu);
> -		if (!event)
> -			continue;
> -		perf_event_disable(event);
> -		per_cpu(nmi_timer_events, cpu) = NULL;
> -		perf_event_release_kernel(event);
> -	}
> -}
> -
> -static int nmi_timer_setup(void)
> -{
> -	int err;
> -	u64 period;
> -
> -	/* clock cycles per tick: */
> -	period = (u64)cpu_khz * 1000;
> -	do_div(period, HZ);
> -	nmi_timer_attr.sample_period = period;
> -
> -	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "oprofile/nmi:online",
> -				nmi_timer_cpu_online, nmi_timer_cpu_predown);
> -	if (err < 0) {
> -		nmi_timer_shutdown();
> -		return err;
> -	}
> -	hp_online = err;
> -	return 0;
> -}
> -
> -int __init op_nmi_timer_init(struct oprofile_operations *ops)
> -{
> -	int err = 0;
> -
> -	err = nmi_timer_setup();
> -	if (err)
> -		return err;
> -	nmi_timer_shutdown();		/* only check, don't alloc */
> -
> -	ops->create_files	= NULL;
> -	ops->setup		= nmi_timer_setup;
> -	ops->shutdown		= nmi_timer_shutdown;
> -	ops->start		= nmi_timer_start;
> -	ops->stop		= nmi_timer_stop;
> -	ops->cpu_type		= "timer";
> -
> -	printk(KERN_INFO "oprofile: using NMI timer interrupt.\n");
> -
> -	return 0;
> -}
> -
> -#endif
> diff --git a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
> deleted file mode 100644
> index ed2c3ec07024..000000000000
> --- a/drivers/oprofile/oprof.c
> +++ /dev/null
> @@ -1,286 +0,0 @@
> -/**
> - * @file oprof.c
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/oprofile.h>
> -#include <linux/moduleparam.h>
> -#include <linux/workqueue.h>
> -#include <linux/time.h>
> -#include <linux/mutex.h>
> -
> -#include "oprof.h"
> -#include "event_buffer.h"
> -#include "cpu_buffer.h"
> -#include "buffer_sync.h"
> -#include "oprofile_stats.h"
> -
> -struct oprofile_operations oprofile_ops;
> -
> -unsigned long oprofile_started;
> -unsigned long oprofile_backtrace_depth;
> -static unsigned long is_setup;
> -static DEFINE_MUTEX(start_mutex);
> -
> -/* timer
> -   0 - use performance monitoring hardware if available
> -   1 - use the timer int mechanism regardless
> - */
> -static int timer = 0;
> -
> -int oprofile_setup(void)
> -{
> -	int err;
> -
> -	mutex_lock(&start_mutex);
> -
> -	if ((err = alloc_cpu_buffers()))
> -		goto out;
> -
> -	if ((err = alloc_event_buffer()))
> -		goto out1;
> -
> -	if (oprofile_ops.setup && (err = oprofile_ops.setup()))
> -		goto out2;
> -
> -	/* Note even though this starts part of the
> -	 * profiling overhead, it's necessary to prevent
> -	 * us missing task deaths and eventually oopsing
> -	 * when trying to process the event buffer.
> -	 */
> -	if (oprofile_ops.sync_start) {
> -		int sync_ret = oprofile_ops.sync_start();
> -		switch (sync_ret) {
> -		case 0:
> -			goto post_sync;
> -		case 1:
> -			goto do_generic;
> -		case -1:
> -			goto out3;
> -		default:
> -			goto out3;
> -		}
> -	}
> -do_generic:
> -	if ((err = sync_start()))
> -		goto out3;
> -
> -post_sync:
> -	is_setup = 1;
> -	mutex_unlock(&start_mutex);
> -	return 0;
> -
> -out3:
> -	if (oprofile_ops.shutdown)
> -		oprofile_ops.shutdown();
> -out2:
> -	free_event_buffer();
> -out1:
> -	free_cpu_buffers();
> -out:
> -	mutex_unlock(&start_mutex);
> -	return err;
> -}
> -
> -#ifdef CONFIG_OPROFILE_EVENT_MULTIPLEX
> -
> -static void switch_worker(struct work_struct *work);
> -static DECLARE_DELAYED_WORK(switch_work, switch_worker);
> -
> -static void start_switch_worker(void)
> -{
> -	if (oprofile_ops.switch_events)
> -		schedule_delayed_work(&switch_work, oprofile_time_slice);
> -}
> -
> -static void stop_switch_worker(void)
> -{
> -	cancel_delayed_work_sync(&switch_work);
> -}
> -
> -static void switch_worker(struct work_struct *work)
> -{
> -	if (oprofile_ops.switch_events())
> -		return;
> -
> -	atomic_inc(&oprofile_stats.multiplex_counter);
> -	start_switch_worker();
> -}
> -
> -/* User inputs in ms, converts to jiffies */
> -int oprofile_set_timeout(unsigned long val_msec)
> -{
> -	int err = 0;
> -	unsigned long time_slice;
> -
> -	mutex_lock(&start_mutex);
> -
> -	if (oprofile_started) {
> -		err = -EBUSY;
> -		goto out;
> -	}
> -
> -	if (!oprofile_ops.switch_events) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
> -	time_slice = msecs_to_jiffies(val_msec);
> -	if (time_slice == MAX_JIFFY_OFFSET) {
> -		err = -EINVAL;
> -		goto out;
> -	}
> -
> -	oprofile_time_slice = time_slice;
> -
> -out:
> -	mutex_unlock(&start_mutex);
> -	return err;
> -
> -}
> -
> -#else
> -
> -static inline void start_switch_worker(void) { }
> -static inline void stop_switch_worker(void) { }
> -
> -#endif
> -
> -/* Actually start profiling (echo 1>/dev/oprofile/enable) */
> -int oprofile_start(void)
> -{
> -	int err = -EINVAL;
> -
> -	mutex_lock(&start_mutex);
> -
> -	if (!is_setup)
> -		goto out;
> -
> -	err = 0;
> -
> -	if (oprofile_started)
> -		goto out;
> -
> -	oprofile_reset_stats();
> -
> -	if ((err = oprofile_ops.start()))
> -		goto out;
> -
> -	start_switch_worker();
> -
> -	oprofile_started = 1;
> -out:
> -	mutex_unlock(&start_mutex);
> -	return err;
> -}
> -
> -
> -/* echo 0>/dev/oprofile/enable */
> -void oprofile_stop(void)
> -{
> -	mutex_lock(&start_mutex);
> -	if (!oprofile_started)
> -		goto out;
> -	oprofile_ops.stop();
> -	oprofile_started = 0;
> -
> -	stop_switch_worker();
> -
> -	/* wake up the daemon to read what remains */
> -	wake_up_buffer_waiter();
> -out:
> -	mutex_unlock(&start_mutex);
> -}
> -
> -
> -void oprofile_shutdown(void)
> -{
> -	mutex_lock(&start_mutex);
> -	if (oprofile_ops.sync_stop) {
> -		int sync_ret = oprofile_ops.sync_stop();
> -		switch (sync_ret) {
> -		case 0:
> -			goto post_sync;
> -		case 1:
> -			goto do_generic;
> -		default:
> -			goto post_sync;
> -		}
> -	}
> -do_generic:
> -	sync_stop();
> -post_sync:
> -	if (oprofile_ops.shutdown)
> -		oprofile_ops.shutdown();
> -	is_setup = 0;
> -	free_event_buffer();
> -	free_cpu_buffers();
> -	mutex_unlock(&start_mutex);
> -}
> -
> -int oprofile_set_ulong(unsigned long *addr, unsigned long val)
> -{
> -	int err = -EBUSY;
> -
> -	mutex_lock(&start_mutex);
> -	if (!oprofile_started) {
> -		*addr = val;
> -		err = 0;
> -	}
> -	mutex_unlock(&start_mutex);
> -
> -	return err;
> -}
> -
> -static int timer_mode;
> -
> -static int __init oprofile_init(void)
> -{
> -	int err;
> -
> -	/* always init architecture to setup backtrace support */
> -	timer_mode = 0;
> -	err = oprofile_arch_init(&oprofile_ops);
> -	if (!err) {
> -		if (!timer && !oprofilefs_register())
> -			return 0;
> -		oprofile_arch_exit();
> -	}
> -
> -	/* setup timer mode: */
> -	timer_mode = 1;
> -	/* no nmi timer mode if oprofile.timer is set */
> -	if (timer || op_nmi_timer_init(&oprofile_ops)) {
> -		err = oprofile_timer_init(&oprofile_ops);
> -		if (err)
> -			return err;
> -	}
> -
> -	return oprofilefs_register();
> -}
> -
> -
> -static void __exit oprofile_exit(void)
> -{
> -	oprofilefs_unregister();
> -	if (!timer_mode)
> -		oprofile_arch_exit();
> -}
> -
> -
> -module_init(oprofile_init);
> -module_exit(oprofile_exit);
> -
> -module_param_named(timer, timer, int, 0644);
> -MODULE_PARM_DESC(timer, "force use of timer interrupt");
> -
> -MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("John Levon <levon@movementarian.org>");
> -MODULE_DESCRIPTION("OProfile system profiler");
> diff --git a/drivers/oprofile/oprof.h b/drivers/oprofile/oprof.h
> deleted file mode 100644
> index d5412060ab0f..000000000000
> --- a/drivers/oprofile/oprof.h
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -/**
> - * @file oprof.h
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - */
> -
> -#ifndef OPROF_H
> -#define OPROF_H
> -
> -int oprofile_setup(void);
> -void oprofile_shutdown(void);
> -
> -int oprofilefs_register(void);
> -void oprofilefs_unregister(void);
> -
> -int oprofile_start(void);
> -void oprofile_stop(void);
> -
> -struct oprofile_operations;
> -
> -extern unsigned long oprofile_buffer_size;
> -extern unsigned long oprofile_cpu_buffer_size;
> -extern unsigned long oprofile_buffer_watershed;
> -extern unsigned long oprofile_time_slice;
> -
> -extern struct oprofile_operations oprofile_ops;
> -extern unsigned long oprofile_started;
> -extern unsigned long oprofile_backtrace_depth;
> -
> -struct dentry;
> -
> -void oprofile_create_files(struct dentry *root);
> -int oprofile_timer_init(struct oprofile_operations *ops);
> -#ifdef CONFIG_OPROFILE_NMI_TIMER
> -int op_nmi_timer_init(struct oprofile_operations *ops);
> -#else
> -static inline int op_nmi_timer_init(struct oprofile_operations *ops)
> -{
> -	return -ENODEV;
> -}
> -#endif
> -
> -
> -int oprofile_set_ulong(unsigned long *addr, unsigned long val);
> -int oprofile_set_timeout(unsigned long time);
> -
> -#endif /* OPROF_H */
> diff --git a/drivers/oprofile/oprofile_files.c b/drivers/oprofile/oprofile_files.c
> deleted file mode 100644
> index ee2cfce358b9..000000000000
> --- a/drivers/oprofile/oprofile_files.c
> +++ /dev/null
> @@ -1,201 +0,0 @@
> -/**
> - * @file oprofile_files.c
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - */
> -
> -#include <linux/fs.h>
> -#include <linux/oprofile.h>
> -#include <linux/jiffies.h>
> -
> -#include "event_buffer.h"
> -#include "oprofile_stats.h"
> -#include "oprof.h"
> -
> -#define BUFFER_SIZE_DEFAULT		131072
> -#define CPU_BUFFER_SIZE_DEFAULT		8192
> -#define BUFFER_WATERSHED_DEFAULT	32768	/* FIXME: tune */
> -#define TIME_SLICE_DEFAULT		1
> -
> -unsigned long oprofile_buffer_size;
> -unsigned long oprofile_cpu_buffer_size;
> -unsigned long oprofile_buffer_watershed;
> -unsigned long oprofile_time_slice;
> -
> -#ifdef CONFIG_OPROFILE_EVENT_MULTIPLEX
> -
> -static ssize_t timeout_read(struct file *file, char __user *buf,
> -		size_t count, loff_t *offset)
> -{
> -	return oprofilefs_ulong_to_user(jiffies_to_msecs(oprofile_time_slice),
> -					buf, count, offset);
> -}
> -
> -
> -static ssize_t timeout_write(struct file *file, char const __user *buf,
> -		size_t count, loff_t *offset)
> -{
> -	unsigned long val;
> -	int retval;
> -
> -	if (*offset)
> -		return -EINVAL;
> -
> -	retval = oprofilefs_ulong_from_user(&val, buf, count);
> -	if (retval <= 0)
> -		return retval;
> -
> -	retval = oprofile_set_timeout(val);
> -
> -	if (retval)
> -		return retval;
> -	return count;
> -}
> -
> -
> -static const struct file_operations timeout_fops = {
> -	.read		= timeout_read,
> -	.write		= timeout_write,
> -	.llseek		= default_llseek,
> -};
> -
> -#endif
> -
> -
> -static ssize_t depth_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
> -{
> -	return oprofilefs_ulong_to_user(oprofile_backtrace_depth, buf, count,
> -					offset);
> -}
> -
> -
> -static ssize_t depth_write(struct file *file, char const __user *buf, size_t count, loff_t *offset)
> -{
> -	unsigned long val;
> -	int retval;
> -
> -	if (*offset)
> -		return -EINVAL;
> -
> -	if (!oprofile_ops.backtrace)
> -		return -EINVAL;
> -
> -	retval = oprofilefs_ulong_from_user(&val, buf, count);
> -	if (retval <= 0)
> -		return retval;
> -
> -	retval = oprofile_set_ulong(&oprofile_backtrace_depth, val);
> -	if (retval)
> -		return retval;
> -
> -	return count;
> -}
> -
> -
> -static const struct file_operations depth_fops = {
> -	.read		= depth_read,
> -	.write		= depth_write,
> -	.llseek		= default_llseek,
> -};
> -
> -
> -static ssize_t pointer_size_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
> -{
> -	return oprofilefs_ulong_to_user(sizeof(void *), buf, count, offset);
> -}
> -
> -
> -static const struct file_operations pointer_size_fops = {
> -	.read		= pointer_size_read,
> -	.llseek		= default_llseek,
> -};
> -
> -
> -static ssize_t cpu_type_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
> -{
> -	return oprofilefs_str_to_user(oprofile_ops.cpu_type, buf, count, offset);
> -}
> -
> -
> -static const struct file_operations cpu_type_fops = {
> -	.read		= cpu_type_read,
> -	.llseek		= default_llseek,
> -};
> -
> -
> -static ssize_t enable_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
> -{
> -	return oprofilefs_ulong_to_user(oprofile_started, buf, count, offset);
> -}
> -
> -
> -static ssize_t enable_write(struct file *file, char const __user *buf, size_t count, loff_t *offset)
> -{
> -	unsigned long val;
> -	int retval;
> -
> -	if (*offset)
> -		return -EINVAL;
> -
> -	retval = oprofilefs_ulong_from_user(&val, buf, count);
> -	if (retval <= 0)
> -		return retval;
> -
> -	retval = 0;
> -	if (val)
> -		retval = oprofile_start();
> -	else
> -		oprofile_stop();
> -
> -	if (retval)
> -		return retval;
> -	return count;
> -}
> -
> -
> -static const struct file_operations enable_fops = {
> -	.read		= enable_read,
> -	.write		= enable_write,
> -	.llseek		= default_llseek,
> -};
> -
> -
> -static ssize_t dump_write(struct file *file, char const __user *buf, size_t count, loff_t *offset)
> -{
> -	wake_up_buffer_waiter();
> -	return count;
> -}
> -
> -
> -static const struct file_operations dump_fops = {
> -	.write		= dump_write,
> -	.llseek		= noop_llseek,
> -};
> -
> -void oprofile_create_files(struct dentry *root)
> -{
> -	/* reinitialize default values */
> -	oprofile_buffer_size =		BUFFER_SIZE_DEFAULT;
> -	oprofile_cpu_buffer_size =	CPU_BUFFER_SIZE_DEFAULT;
> -	oprofile_buffer_watershed =	BUFFER_WATERSHED_DEFAULT;
> -	oprofile_time_slice =		msecs_to_jiffies(TIME_SLICE_DEFAULT);
> -
> -	oprofilefs_create_file(root, "enable", &enable_fops);
> -	oprofilefs_create_file_perm(root, "dump", &dump_fops, 0666);
> -	oprofilefs_create_file(root, "buffer", &event_buffer_fops);
> -	oprofilefs_create_ulong(root, "buffer_size", &oprofile_buffer_size);
> -	oprofilefs_create_ulong(root, "buffer_watershed", &oprofile_buffer_watershed);
> -	oprofilefs_create_ulong(root, "cpu_buffer_size", &oprofile_cpu_buffer_size);
> -	oprofilefs_create_file(root, "cpu_type", &cpu_type_fops);
> -	oprofilefs_create_file(root, "backtrace_depth", &depth_fops);
> -	oprofilefs_create_file(root, "pointer_size", &pointer_size_fops);
> -#ifdef CONFIG_OPROFILE_EVENT_MULTIPLEX
> -	oprofilefs_create_file(root, "time_slice", &timeout_fops);
> -#endif
> -	oprofile_create_stats_files(root);
> -	if (oprofile_ops.create_files)
> -		oprofile_ops.create_files(root);
> -}
> diff --git a/drivers/oprofile/oprofile_perf.c b/drivers/oprofile/oprofile_perf.c
> deleted file mode 100644
> index 98a63a5f8763..000000000000
> --- a/drivers/oprofile/oprofile_perf.c
> +++ /dev/null
> @@ -1,328 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright 2010 ARM Ltd.
> - * Copyright 2012 Advanced Micro Devices, Inc., Robert Richter
> - *
> - * Perf-events backend for OProfile.
> - */
> -#include <linux/perf_event.h>
> -#include <linux/platform_device.h>
> -#include <linux/oprofile.h>
> -#include <linux/slab.h>
> -
> -/*
> - * Per performance monitor configuration as set via oprofilefs.
> - */
> -struct op_counter_config {
> -	unsigned long count;
> -	unsigned long enabled;
> -	unsigned long event;
> -	unsigned long unit_mask;
> -	unsigned long kernel;
> -	unsigned long user;
> -	struct perf_event_attr attr;
> -};
> -
> -static int oprofile_perf_enabled;
> -static DEFINE_MUTEX(oprofile_perf_mutex);
> -
> -static struct op_counter_config *counter_config;
> -static DEFINE_PER_CPU(struct perf_event **, perf_events);
> -static int num_counters;
> -
> -/*
> - * Overflow callback for oprofile.
> - */
> -static void op_overflow_handler(struct perf_event *event,
> -			struct perf_sample_data *data, struct pt_regs *regs)
> -{
> -	int id;
> -	u32 cpu = smp_processor_id();
> -
> -	for (id = 0; id < num_counters; ++id)
> -		if (per_cpu(perf_events, cpu)[id] == event)
> -			break;
> -
> -	if (id != num_counters)
> -		oprofile_add_sample(regs, id);
> -	else
> -		pr_warn("oprofile: ignoring spurious overflow on cpu %u\n",
> -			cpu);
> -}
> -
> -/*
> - * Called by oprofile_perf_setup to create perf attributes to mirror the oprofile
> - * settings in counter_config. Attributes are created as `pinned' events and
> - * so are permanently scheduled on the PMU.
> - */
> -static void op_perf_setup(void)
> -{
> -	int i;
> -	u32 size = sizeof(struct perf_event_attr);
> -	struct perf_event_attr *attr;
> -
> -	for (i = 0; i < num_counters; ++i) {
> -		attr = &counter_config[i].attr;
> -		memset(attr, 0, size);
> -		attr->type		= PERF_TYPE_RAW;
> -		attr->size		= size;
> -		attr->config		= counter_config[i].event;
> -		attr->sample_period	= counter_config[i].count;
> -		attr->pinned		= 1;
> -	}
> -}
> -
> -static int op_create_counter(int cpu, int event)
> -{
> -	struct perf_event *pevent;
> -
> -	if (!counter_config[event].enabled || per_cpu(perf_events, cpu)[event])
> -		return 0;
> -
> -	pevent = perf_event_create_kernel_counter(&counter_config[event].attr,
> -						  cpu, NULL,
> -						  op_overflow_handler, NULL);
> -
> -	if (IS_ERR(pevent))
> -		return PTR_ERR(pevent);
> -
> -	if (pevent->state != PERF_EVENT_STATE_ACTIVE) {
> -		perf_event_release_kernel(pevent);
> -		pr_warn("oprofile: failed to enable event %d on CPU %d\n",
> -			event, cpu);
> -		return -EBUSY;
> -	}
> -
> -	per_cpu(perf_events, cpu)[event] = pevent;
> -
> -	return 0;
> -}
> -
> -static void op_destroy_counter(int cpu, int event)
> -{
> -	struct perf_event *pevent = per_cpu(perf_events, cpu)[event];
> -
> -	if (pevent) {
> -		perf_event_release_kernel(pevent);
> -		per_cpu(perf_events, cpu)[event] = NULL;
> -	}
> -}
> -
> -/*
> - * Called by oprofile_perf_start to create active perf events based on the
> - * perviously configured attributes.
> - */
> -static int op_perf_start(void)
> -{
> -	int cpu, event, ret = 0;
> -
> -	for_each_online_cpu(cpu) {
> -		for (event = 0; event < num_counters; ++event) {
> -			ret = op_create_counter(cpu, event);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	return ret;
> -}
> -
> -/*
> - * Called by oprofile_perf_stop at the end of a profiling run.
> - */
> -static void op_perf_stop(void)
> -{
> -	int cpu, event;
> -
> -	for_each_online_cpu(cpu)
> -		for (event = 0; event < num_counters; ++event)
> -			op_destroy_counter(cpu, event);
> -}
> -
> -static int oprofile_perf_create_files(struct dentry *root)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < num_counters; i++) {
> -		struct dentry *dir;
> -		char buf[4];
> -
> -		snprintf(buf, sizeof buf, "%d", i);
> -		dir = oprofilefs_mkdir(root, buf);
> -		oprofilefs_create_ulong(dir, "enabled", &counter_config[i].enabled);
> -		oprofilefs_create_ulong(dir, "event", &counter_config[i].event);
> -		oprofilefs_create_ulong(dir, "count", &counter_config[i].count);
> -		oprofilefs_create_ulong(dir, "unit_mask", &counter_config[i].unit_mask);
> -		oprofilefs_create_ulong(dir, "kernel", &counter_config[i].kernel);
> -		oprofilefs_create_ulong(dir, "user", &counter_config[i].user);
> -	}
> -
> -	return 0;
> -}
> -
> -static int oprofile_perf_setup(void)
> -{
> -	raw_spin_lock(&oprofilefs_lock);
> -	op_perf_setup();
> -	raw_spin_unlock(&oprofilefs_lock);
> -	return 0;
> -}
> -
> -static int oprofile_perf_start(void)
> -{
> -	int ret = -EBUSY;
> -
> -	mutex_lock(&oprofile_perf_mutex);
> -	if (!oprofile_perf_enabled) {
> -		ret = 0;
> -		op_perf_start();
> -		oprofile_perf_enabled = 1;
> -	}
> -	mutex_unlock(&oprofile_perf_mutex);
> -	return ret;
> -}
> -
> -static void oprofile_perf_stop(void)
> -{
> -	mutex_lock(&oprofile_perf_mutex);
> -	if (oprofile_perf_enabled)
> -		op_perf_stop();
> -	oprofile_perf_enabled = 0;
> -	mutex_unlock(&oprofile_perf_mutex);
> -}
> -
> -#ifdef CONFIG_PM
> -
> -static int oprofile_perf_suspend(struct platform_device *dev, pm_message_t state)
> -{
> -	mutex_lock(&oprofile_perf_mutex);
> -	if (oprofile_perf_enabled)
> -		op_perf_stop();
> -	mutex_unlock(&oprofile_perf_mutex);
> -	return 0;
> -}
> -
> -static int oprofile_perf_resume(struct platform_device *dev)
> -{
> -	mutex_lock(&oprofile_perf_mutex);
> -	if (oprofile_perf_enabled && op_perf_start())
> -		oprofile_perf_enabled = 0;
> -	mutex_unlock(&oprofile_perf_mutex);
> -	return 0;
> -}
> -
> -static struct platform_driver oprofile_driver = {
> -	.driver		= {
> -		.name		= "oprofile-perf",
> -	},
> -	.resume		= oprofile_perf_resume,
> -	.suspend	= oprofile_perf_suspend,
> -};
> -
> -static struct platform_device *oprofile_pdev;
> -
> -static int __init init_driverfs(void)
> -{
> -	int ret;
> -
> -	ret = platform_driver_register(&oprofile_driver);
> -	if (ret)
> -		return ret;
> -
> -	oprofile_pdev =	platform_device_register_simple(
> -				oprofile_driver.driver.name, 0, NULL, 0);
> -	if (IS_ERR(oprofile_pdev)) {
> -		ret = PTR_ERR(oprofile_pdev);
> -		platform_driver_unregister(&oprofile_driver);
> -	}
> -
> -	return ret;
> -}
> -
> -static void exit_driverfs(void)
> -{
> -	platform_device_unregister(oprofile_pdev);
> -	platform_driver_unregister(&oprofile_driver);
> -}
> -
> -#else
> -
> -static inline int  init_driverfs(void) { return 0; }
> -static inline void exit_driverfs(void) { }
> -
> -#endif /* CONFIG_PM */
> -
> -void oprofile_perf_exit(void)
> -{
> -	int cpu, id;
> -	struct perf_event *event;
> -
> -	for_each_possible_cpu(cpu) {
> -		for (id = 0; id < num_counters; ++id) {
> -			event = per_cpu(perf_events, cpu)[id];
> -			if (event)
> -				perf_event_release_kernel(event);
> -		}
> -
> -		kfree(per_cpu(perf_events, cpu));
> -	}
> -
> -	kfree(counter_config);
> -	exit_driverfs();
> -}
> -
> -int __init oprofile_perf_init(struct oprofile_operations *ops)
> -{
> -	int cpu, ret = 0;
> -
> -	ret = init_driverfs();
> -	if (ret)
> -		return ret;
> -
> -	num_counters = perf_num_counters();
> -	if (num_counters <= 0) {
> -		pr_info("oprofile: no performance counters\n");
> -		ret = -ENODEV;
> -		goto out;
> -	}
> -
> -	counter_config = kcalloc(num_counters,
> -			sizeof(struct op_counter_config), GFP_KERNEL);
> -
> -	if (!counter_config) {
> -		pr_info("oprofile: failed to allocate %d "
> -				"counters\n", num_counters);
> -		ret = -ENOMEM;
> -		num_counters = 0;
> -		goto out;
> -	}
> -
> -	for_each_possible_cpu(cpu) {
> -		per_cpu(perf_events, cpu) = kcalloc(num_counters,
> -				sizeof(struct perf_event *), GFP_KERNEL);
> -		if (!per_cpu(perf_events, cpu)) {
> -			pr_info("oprofile: failed to allocate %d perf events "
> -					"for cpu %d\n", num_counters, cpu);
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> -	}
> -
> -	ops->create_files	= oprofile_perf_create_files;
> -	ops->setup		= oprofile_perf_setup;
> -	ops->start		= oprofile_perf_start;
> -	ops->stop		= oprofile_perf_stop;
> -	ops->shutdown		= oprofile_perf_stop;
> -	ops->cpu_type		= op_name_from_perf_id();
> -
> -	if (!ops->cpu_type)
> -		ret = -ENODEV;
> -	else
> -		pr_info("oprofile: using %s\n", ops->cpu_type);
> -
> -out:
> -	if (ret)
> -		oprofile_perf_exit();
> -
> -	return ret;
> -}
> diff --git a/drivers/oprofile/oprofile_stats.c b/drivers/oprofile/oprofile_stats.c
> deleted file mode 100644
> index 59659cea4582..000000000000
> --- a/drivers/oprofile/oprofile_stats.c
> +++ /dev/null
> @@ -1,84 +0,0 @@
> -/**
> - * @file oprofile_stats.c
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon
> - */
> -
> -#include <linux/oprofile.h>
> -#include <linux/smp.h>
> -#include <linux/cpumask.h>
> -#include <linux/threads.h>
> -
> -#include "oprofile_stats.h"
> -#include "cpu_buffer.h"
> -
> -struct oprofile_stat_struct oprofile_stats;
> -
> -void oprofile_reset_stats(void)
> -{
> -	struct oprofile_cpu_buffer *cpu_buf;
> -	int i;
> -
> -	for_each_possible_cpu(i) {
> -		cpu_buf = &per_cpu(op_cpu_buffer, i);
> -		cpu_buf->sample_received = 0;
> -		cpu_buf->sample_lost_overflow = 0;
> -		cpu_buf->backtrace_aborted = 0;
> -		cpu_buf->sample_invalid_eip = 0;
> -	}
> -
> -	atomic_set(&oprofile_stats.sample_lost_no_mm, 0);
> -	atomic_set(&oprofile_stats.sample_lost_no_mapping, 0);
> -	atomic_set(&oprofile_stats.event_lost_overflow, 0);
> -	atomic_set(&oprofile_stats.bt_lost_no_mapping, 0);
> -	atomic_set(&oprofile_stats.multiplex_counter, 0);
> -}
> -
> -
> -void oprofile_create_stats_files(struct dentry *root)
> -{
> -	struct oprofile_cpu_buffer *cpu_buf;
> -	struct dentry *cpudir;
> -	struct dentry *dir;
> -	char buf[10];
> -	int i;
> -
> -	dir = oprofilefs_mkdir(root, "stats");
> -	if (!dir)
> -		return;
> -
> -	for_each_possible_cpu(i) {
> -		cpu_buf = &per_cpu(op_cpu_buffer, i);
> -		snprintf(buf, 10, "cpu%d", i);
> -		cpudir = oprofilefs_mkdir(dir, buf);
> -
> -		/* Strictly speaking access to these ulongs is racy,
> -		 * but we can't simply lock them, and they are
> -		 * informational only.
> -		 */
> -		oprofilefs_create_ro_ulong(cpudir, "sample_received",
> -			&cpu_buf->sample_received);
> -		oprofilefs_create_ro_ulong(cpudir, "sample_lost_overflow",
> -			&cpu_buf->sample_lost_overflow);
> -		oprofilefs_create_ro_ulong(cpudir, "backtrace_aborted",
> -			&cpu_buf->backtrace_aborted);
> -		oprofilefs_create_ro_ulong(cpudir, "sample_invalid_eip",
> -			&cpu_buf->sample_invalid_eip);
> -	}
> -
> -	oprofilefs_create_ro_atomic(dir, "sample_lost_no_mm",
> -		&oprofile_stats.sample_lost_no_mm);
> -	oprofilefs_create_ro_atomic(dir, "sample_lost_no_mapping",
> -		&oprofile_stats.sample_lost_no_mapping);
> -	oprofilefs_create_ro_atomic(dir, "event_lost_overflow",
> -		&oprofile_stats.event_lost_overflow);
> -	oprofilefs_create_ro_atomic(dir, "bt_lost_no_mapping",
> -		&oprofile_stats.bt_lost_no_mapping);
> -#ifdef CONFIG_OPROFILE_EVENT_MULTIPLEX
> -	oprofilefs_create_ro_atomic(dir, "multiplex_counter",
> -		&oprofile_stats.multiplex_counter);
> -#endif
> -}
> diff --git a/drivers/oprofile/oprofile_stats.h b/drivers/oprofile/oprofile_stats.h
> deleted file mode 100644
> index 1fc622bd1834..000000000000
> --- a/drivers/oprofile/oprofile_stats.h
> +++ /dev/null
> @@ -1,33 +0,0 @@
> -/**
> - * @file oprofile_stats.h
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon
> - */
> -
> -#ifndef OPROFILE_STATS_H
> -#define OPROFILE_STATS_H
> -
> -#include <linux/atomic.h>
> -
> -struct oprofile_stat_struct {
> -	atomic_t sample_lost_no_mm;
> -	atomic_t sample_lost_no_mapping;
> -	atomic_t bt_lost_no_mapping;
> -	atomic_t event_lost_overflow;
> -	atomic_t multiplex_counter;
> -};
> -
> -extern struct oprofile_stat_struct oprofile_stats;
> -
> -/* reset all stats to zero */
> -void oprofile_reset_stats(void);
> -
> -struct dentry;
> -
> -/* create the stats/ dir */
> -void oprofile_create_stats_files(struct dentry *root);
> -
> -#endif /* OPROFILE_STATS_H */
> diff --git a/drivers/oprofile/oprofilefs.c b/drivers/oprofile/oprofilefs.c
> deleted file mode 100644
> index 0875f2f122b3..000000000000
> --- a/drivers/oprofile/oprofilefs.c
> +++ /dev/null
> @@ -1,300 +0,0 @@
> -/**
> - * @file oprofilefs.c
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon
> - *
> - * A simple filesystem for configuration and
> - * access of oprofile.
> - */
> -
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/oprofile.h>
> -#include <linux/fs.h>
> -#include <linux/fs_context.h>
> -#include <linux/pagemap.h>
> -#include <linux/uaccess.h>
> -
> -#include "oprof.h"
> -
> -#define OPROFILEFS_MAGIC 0x6f70726f
> -
> -DEFINE_RAW_SPINLOCK(oprofilefs_lock);
> -
> -static struct inode *oprofilefs_get_inode(struct super_block *sb, int mode)
> -{
> -	struct inode *inode = new_inode(sb);
> -
> -	if (inode) {
> -		inode->i_ino = get_next_ino();
> -		inode->i_mode = mode;
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> -	}
> -	return inode;
> -}
> -
> -
> -static const struct super_operations s_ops = {
> -	.statfs		= simple_statfs,
> -	.drop_inode 	= generic_delete_inode,
> -};
> -
> -
> -ssize_t oprofilefs_str_to_user(char const *str, char __user *buf, size_t count, loff_t *offset)
> -{
> -	return simple_read_from_buffer(buf, count, offset, str, strlen(str));
> -}
> -
> -
> -#define TMPBUFSIZE 50
> -
> -ssize_t oprofilefs_ulong_to_user(unsigned long val, char __user *buf, size_t count, loff_t *offset)
> -{
> -	char tmpbuf[TMPBUFSIZE];
> -	size_t maxlen = snprintf(tmpbuf, TMPBUFSIZE, "%lu\n", val);
> -	if (maxlen > TMPBUFSIZE)
> -		maxlen = TMPBUFSIZE;
> -	return simple_read_from_buffer(buf, count, offset, tmpbuf, maxlen);
> -}
> -
> -
> -/*
> - * Note: If oprofilefs_ulong_from_user() returns 0, then *val remains
> - * unchanged and might be uninitialized. This follows write syscall
> - * implementation when count is zero: "If count is zero ... [and if]
> - * no errors are detected, 0 will be returned without causing any
> - * other effect." (man 2 write)
> - */
> -int oprofilefs_ulong_from_user(unsigned long *val, char const __user *buf, size_t count)
> -{
> -	char tmpbuf[TMPBUFSIZE];
> -	unsigned long flags;
> -
> -	if (!count)
> -		return 0;
> -
> -	if (count > TMPBUFSIZE - 1)
> -		return -EINVAL;
> -
> -	memset(tmpbuf, 0x0, TMPBUFSIZE);
> -
> -	if (copy_from_user(tmpbuf, buf, count))
> -		return -EFAULT;
> -
> -	raw_spin_lock_irqsave(&oprofilefs_lock, flags);
> -	*val = simple_strtoul(tmpbuf, NULL, 0);
> -	raw_spin_unlock_irqrestore(&oprofilefs_lock, flags);
> -	return count;
> -}
> -
> -
> -static ssize_t ulong_read_file(struct file *file, char __user *buf, size_t count, loff_t *offset)
> -{
> -	unsigned long *val = file->private_data;
> -	return oprofilefs_ulong_to_user(*val, buf, count, offset);
> -}
> -
> -
> -static ssize_t ulong_write_file(struct file *file, char const __user *buf, size_t count, loff_t *offset)
> -{
> -	unsigned long value;
> -	int retval;
> -
> -	if (*offset)
> -		return -EINVAL;
> -
> -	retval = oprofilefs_ulong_from_user(&value, buf, count);
> -	if (retval <= 0)
> -		return retval;
> -
> -	retval = oprofile_set_ulong(file->private_data, value);
> -	if (retval)
> -		return retval;
> -
> -	return count;
> -}
> -
> -
> -static const struct file_operations ulong_fops = {
> -	.read		= ulong_read_file,
> -	.write		= ulong_write_file,
> -	.open		= simple_open,
> -	.llseek		= default_llseek,
> -};
> -
> -
> -static const struct file_operations ulong_ro_fops = {
> -	.read		= ulong_read_file,
> -	.open		= simple_open,
> -	.llseek		= default_llseek,
> -};
> -
> -
> -static int __oprofilefs_create_file(struct dentry *root, char const *name,
> -	const struct file_operations *fops, int perm, void *priv)
> -{
> -	struct dentry *dentry;
> -	struct inode *inode;
> -
> -	if (!root)
> -		return -ENOMEM;
> -
> -	inode_lock(d_inode(root));
> -	dentry = d_alloc_name(root, name);
> -	if (!dentry) {
> -		inode_unlock(d_inode(root));
> -		return -ENOMEM;
> -	}
> -	inode = oprofilefs_get_inode(root->d_sb, S_IFREG | perm);
> -	if (!inode) {
> -		dput(dentry);
> -		inode_unlock(d_inode(root));
> -		return -ENOMEM;
> -	}
> -	inode->i_fop = fops;
> -	inode->i_private = priv;
> -	d_add(dentry, inode);
> -	inode_unlock(d_inode(root));
> -	return 0;
> -}
> -
> -
> -int oprofilefs_create_ulong(struct dentry *root,
> -	char const *name, unsigned long *val)
> -{
> -	return __oprofilefs_create_file(root, name,
> -					&ulong_fops, 0644, val);
> -}
> -
> -
> -int oprofilefs_create_ro_ulong(struct dentry *root,
> -	char const *name, unsigned long *val)
> -{
> -	return __oprofilefs_create_file(root, name,
> -					&ulong_ro_fops, 0444, val);
> -}
> -
> -
> -static ssize_t atomic_read_file(struct file *file, char __user *buf, size_t count, loff_t *offset)
> -{
> -	atomic_t *val = file->private_data;
> -	return oprofilefs_ulong_to_user(atomic_read(val), buf, count, offset);
> -}
> -
> -
> -static const struct file_operations atomic_ro_fops = {
> -	.read		= atomic_read_file,
> -	.open		= simple_open,
> -	.llseek		= default_llseek,
> -};
> -
> -
> -int oprofilefs_create_ro_atomic(struct dentry *root,
> -	char const *name, atomic_t *val)
> -{
> -	return __oprofilefs_create_file(root, name,
> -					&atomic_ro_fops, 0444, val);
> -}
> -
> -
> -int oprofilefs_create_file(struct dentry *root,
> -	char const *name, const struct file_operations *fops)
> -{
> -	return __oprofilefs_create_file(root, name, fops, 0644, NULL);
> -}
> -
> -
> -int oprofilefs_create_file_perm(struct dentry *root,
> -	char const *name, const struct file_operations *fops, int perm)
> -{
> -	return __oprofilefs_create_file(root, name, fops, perm, NULL);
> -}
> -
> -
> -struct dentry *oprofilefs_mkdir(struct dentry *parent, char const *name)
> -{
> -	struct dentry *dentry;
> -	struct inode *inode;
> -
> -	inode_lock(d_inode(parent));
> -	dentry = d_alloc_name(parent, name);
> -	if (!dentry) {
> -		inode_unlock(d_inode(parent));
> -		return NULL;
> -	}
> -	inode = oprofilefs_get_inode(parent->d_sb, S_IFDIR | 0755);
> -	if (!inode) {
> -		dput(dentry);
> -		inode_unlock(d_inode(parent));
> -		return NULL;
> -	}
> -	inode->i_op = &simple_dir_inode_operations;
> -	inode->i_fop = &simple_dir_operations;
> -	d_add(dentry, inode);
> -	inode_unlock(d_inode(parent));
> -	return dentry;
> -}
> -
> -
> -static int oprofilefs_fill_super(struct super_block *sb, struct fs_context *fc)
> -{
> -	struct inode *root_inode;
> -
> -	sb->s_blocksize = PAGE_SIZE;
> -	sb->s_blocksize_bits = PAGE_SHIFT;
> -	sb->s_magic = OPROFILEFS_MAGIC;
> -	sb->s_op = &s_ops;
> -	sb->s_time_gran = 1;
> -
> -	root_inode = oprofilefs_get_inode(sb, S_IFDIR | 0755);
> -	if (!root_inode)
> -		return -ENOMEM;
> -	root_inode->i_op = &simple_dir_inode_operations;
> -	root_inode->i_fop = &simple_dir_operations;
> -	sb->s_root = d_make_root(root_inode);
> -	if (!sb->s_root)
> -		return -ENOMEM;
> -
> -	oprofile_create_files(sb->s_root);
> -
> -	// FIXME: verify kill_litter_super removes our dentries
> -	return 0;
> -}
> -
> -static int oprofilefs_get_tree(struct fs_context *fc)
> -{
> -	return get_tree_single(fc, oprofilefs_fill_super);
> -}
> -
> -static const struct fs_context_operations oprofilefs_context_ops = {
> -	.get_tree	= oprofilefs_get_tree,
> -};
> -
> -static int oprofilefs_init_fs_context(struct fs_context *fc)
> -{
> -	fc->ops = &oprofilefs_context_ops;
> -	return 0;
> -}
> -
> -static struct file_system_type oprofilefs_type = {
> -	.owner		= THIS_MODULE,
> -	.name		= "oprofilefs",
> -	.init_fs_context = oprofilefs_init_fs_context,
> -	.kill_sb	= kill_litter_super,
> -};
> -MODULE_ALIAS_FS("oprofilefs");
> -
> -
> -int __init oprofilefs_register(void)
> -{
> -	return register_filesystem(&oprofilefs_type);
> -}
> -
> -
> -void __exit oprofilefs_unregister(void)
> -{
> -	unregister_filesystem(&oprofilefs_type);
> -}
> diff --git a/drivers/oprofile/timer_int.c b/drivers/oprofile/timer_int.c
> deleted file mode 100644
> index 2498a6cd7c24..000000000000
> --- a/drivers/oprofile/timer_int.c
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -/**
> - * @file timer_int.c
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/notifier.h>
> -#include <linux/smp.h>
> -#include <linux/oprofile.h>
> -#include <linux/profile.h>
> -#include <linux/init.h>
> -#include <linux/cpu.h>
> -#include <linux/hrtimer.h>
> -#include <asm/irq_regs.h>
> -#include <asm/ptrace.h>
> -
> -#include "oprof.h"
> -
> -static DEFINE_PER_CPU(struct hrtimer, oprofile_hrtimer);
> -static int ctr_running;
> -
> -static enum hrtimer_restart oprofile_hrtimer_notify(struct hrtimer *hrtimer)
> -{
> -	oprofile_add_sample(get_irq_regs(), 0);
> -	hrtimer_forward_now(hrtimer, ns_to_ktime(TICK_NSEC));
> -	return HRTIMER_RESTART;
> -}
> -
> -static void __oprofile_hrtimer_start(void *unused)
> -{
> -	struct hrtimer *hrtimer = this_cpu_ptr(&oprofile_hrtimer);
> -
> -	if (!ctr_running)
> -		return;
> -
> -	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> -	hrtimer->function = oprofile_hrtimer_notify;
> -
> -	hrtimer_start(hrtimer, ns_to_ktime(TICK_NSEC),
> -		      HRTIMER_MODE_REL_PINNED);
> -}
> -
> -static int oprofile_hrtimer_start(void)
> -{
> -	get_online_cpus();
> -	ctr_running = 1;
> -	on_each_cpu(__oprofile_hrtimer_start, NULL, 1);
> -	put_online_cpus();
> -	return 0;
> -}
> -
> -static void __oprofile_hrtimer_stop(int cpu)
> -{
> -	struct hrtimer *hrtimer = &per_cpu(oprofile_hrtimer, cpu);
> -
> -	if (!ctr_running)
> -		return;
> -
> -	hrtimer_cancel(hrtimer);
> -}
> -
> -static void oprofile_hrtimer_stop(void)
> -{
> -	int cpu;
> -
> -	get_online_cpus();
> -	for_each_online_cpu(cpu)
> -		__oprofile_hrtimer_stop(cpu);
> -	ctr_running = 0;
> -	put_online_cpus();
> -}
> -
> -static int oprofile_timer_online(unsigned int cpu)
> -{
> -	local_irq_disable();
> -	__oprofile_hrtimer_start(NULL);
> -	local_irq_enable();
> -	return 0;
> -}
> -
> -static int oprofile_timer_prep_down(unsigned int cpu)
> -{
> -	__oprofile_hrtimer_stop(cpu);
> -	return 0;
> -}
> -
> -static enum cpuhp_state hp_online;
> -
> -static int oprofile_hrtimer_setup(void)
> -{
> -	int ret;
> -
> -	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> -					"oprofile/timer:online",
> -					oprofile_timer_online,
> -					oprofile_timer_prep_down);
> -	if (ret < 0)
> -		return ret;
> -	hp_online = ret;
> -	return 0;
> -}
> -
> -static void oprofile_hrtimer_shutdown(void)
> -{
> -	cpuhp_remove_state_nocalls(hp_online);
> -}
> -
> -int oprofile_timer_init(struct oprofile_operations *ops)
> -{
> -	ops->create_files	= NULL;
> -	ops->setup		= oprofile_hrtimer_setup;
> -	ops->shutdown		= oprofile_hrtimer_shutdown;
> -	ops->start		= oprofile_hrtimer_start;
> -	ops->stop		= oprofile_hrtimer_stop;
> -	ops->cpu_type		= "timer";
> -	printk(KERN_INFO "oprofile: using timer interrupt.\n");
> -	return 0;
> -}
> diff --git a/include/linux/oprofile.h b/include/linux/oprofile.h
> deleted file mode 100644
> index b2a0f15f11fe..000000000000
> --- a/include/linux/oprofile.h
> +++ /dev/null
> @@ -1,209 +0,0 @@
> -/**
> - * @file oprofile.h
> - *
> - * API for machine-specific interrupts to interface
> - * to oprofile.
> - *
> - * @remark Copyright 2002 OProfile authors
> - * @remark Read the file COPYING
> - *
> - * @author John Levon <levon@movementarian.org>
> - */
> -
> -#ifndef OPROFILE_H
> -#define OPROFILE_H
> -
> -#include <linux/types.h>
> -#include <linux/spinlock.h>
> -#include <linux/init.h>
> -#include <linux/errno.h>
> -#include <linux/printk.h>
> -#include <linux/atomic.h>
> - 
> -/* Each escaped entry is prefixed by ESCAPE_CODE
> - * then one of the following codes, then the
> - * relevant data.
> - * These #defines live in this file so that arch-specific
> - * buffer sync'ing code can access them.
> - */
> -#define ESCAPE_CODE			~0UL
> -#define CTX_SWITCH_CODE			1
> -#define CPU_SWITCH_CODE			2
> -#define COOKIE_SWITCH_CODE		3
> -#define KERNEL_ENTER_SWITCH_CODE	4
> -#define KERNEL_EXIT_SWITCH_CODE		5
> -#define MODULE_LOADED_CODE		6
> -#define CTX_TGID_CODE			7
> -#define TRACE_BEGIN_CODE		8
> -#define TRACE_END_CODE			9
> -#define XEN_ENTER_SWITCH_CODE		10
> -#define SPU_PROFILING_CODE		11
> -#define SPU_CTX_SWITCH_CODE		12
> -#define IBS_FETCH_CODE			13
> -#define IBS_OP_CODE			14
> -
> -struct dentry;
> -struct file_operations;
> -struct pt_regs;
> - 
> -/* Operations structure to be filled in */
> -struct oprofile_operations {
> -	/* create any necessary configuration files in the oprofile fs.
> -	 * Optional. */
> -	int (*create_files)(struct dentry * root);
> -	/* Do any necessary interrupt setup. Optional. */
> -	int (*setup)(void);
> -	/* Do any necessary interrupt shutdown. Optional. */
> -	void (*shutdown)(void);
> -	/* Start delivering interrupts. */
> -	int (*start)(void);
> -	/* Stop delivering interrupts. */
> -	void (*stop)(void);
> -	/* Arch-specific buffer sync functions.
> -	 * Return value = 0:  Success
> -	 * Return value = -1: Failure
> -	 * Return value = 1:  Run generic sync function
> -	 */
> -	int (*sync_start)(void);
> -	int (*sync_stop)(void);
> -
> -	/* Initiate a stack backtrace. Optional. */
> -	void (*backtrace)(struct pt_regs * const regs, unsigned int depth);
> -
> -	/* Multiplex between different events. Optional. */
> -	int (*switch_events)(void);
> -	/* CPU identification string. */
> -	char * cpu_type;
> -};
> -
> -/**
> - * One-time initialisation. *ops must be set to a filled-in
> - * operations structure. This is called even in timer interrupt
> - * mode so an arch can set a backtrace callback.
> - *
> - * If an error occurs, the fields should be left untouched.
> - */
> -int oprofile_arch_init(struct oprofile_operations * ops);
> - 
> -/**
> - * One-time exit/cleanup for the arch.
> - */
> -void oprofile_arch_exit(void);
> -
> -/**
> - * Add a sample. This may be called from any context.
> - */
> -void oprofile_add_sample(struct pt_regs * const regs, unsigned long event);
> -
> -/**
> - * Add an extended sample.  Use this when the PC is not from the regs, and
> - * we cannot determine if we're in kernel mode from the regs.
> - *
> - * This function does perform a backtrace.
> - *
> - */
> -void oprofile_add_ext_sample(unsigned long pc, struct pt_regs * const regs,
> -				unsigned long event, int is_kernel);
> -
> -/**
> - * Add an hardware sample.
> - */
> -void oprofile_add_ext_hw_sample(unsigned long pc, struct pt_regs * const regs,
> -	unsigned long event, int is_kernel,
> -	struct task_struct *task);
> -
> -/* Use this instead when the PC value is not from the regs. Doesn't
> - * backtrace. */
> -void oprofile_add_pc(unsigned long pc, int is_kernel, unsigned long event);
> -
> -/* add a backtrace entry, to be called from the ->backtrace callback */
> -void oprofile_add_trace(unsigned long eip);
> -
> -
> -/**
> - * Create a file of the given name as a child of the given root, with
> - * the specified file operations.
> - */
> -int oprofilefs_create_file(struct dentry * root,
> -	char const * name, const struct file_operations * fops);
> -
> -int oprofilefs_create_file_perm(struct dentry * root,
> -	char const * name, const struct file_operations * fops, int perm);
> - 
> -/** Create a file for read/write access to an unsigned long. */
> -int oprofilefs_create_ulong(struct dentry * root,
> -	char const * name, ulong * val);
> - 
> -/** Create a file for read-only access to an unsigned long. */
> -int oprofilefs_create_ro_ulong(struct dentry * root,
> -	char const * name, ulong * val);
> - 
> -/** Create a file for read-only access to an atomic_t. */
> -int oprofilefs_create_ro_atomic(struct dentry * root,
> -	char const * name, atomic_t * val);
> - 
> -/** create a directory */
> -struct dentry *oprofilefs_mkdir(struct dentry *parent, char const *name);
> -
> -/**
> - * Write the given asciz string to the given user buffer @buf, updating *offset
> - * appropriately. Returns bytes written or -EFAULT.
> - */
> -ssize_t oprofilefs_str_to_user(char const * str, char __user * buf, size_t count, loff_t * offset);
> -
> -/**
> - * Convert an unsigned long value into ASCII and copy it to the user buffer @buf,
> - * updating *offset appropriately. Returns bytes written or -EFAULT.
> - */
> -ssize_t oprofilefs_ulong_to_user(unsigned long val, char __user * buf, size_t count, loff_t * offset);
> -
> -/**
> - * Read an ASCII string for a number from a userspace buffer and fill *val on success.
> - * Returns 0 on success, < 0 on error.
> - */
> -int oprofilefs_ulong_from_user(unsigned long * val, char const __user * buf, size_t count);
> -
> -/** lock for read/write safety */
> -extern raw_spinlock_t oprofilefs_lock;
> -
> -/**
> - * Add the contents of a circular buffer to the event buffer.
> - */
> -void oprofile_put_buff(unsigned long *buf, unsigned int start,
> -			unsigned int stop, unsigned int max);
> -
> -unsigned long oprofile_get_cpu_buffer_size(void);
> -void oprofile_cpu_buffer_inc_smpl_lost(void);
> - 
> -/* cpu buffer functions */
> -
> -struct op_sample;
> -
> -struct op_entry {
> -	struct ring_buffer_event *event;
> -	struct op_sample *sample;
> -	unsigned long size;
> -	unsigned long *data;
> -};
> -
> -void oprofile_write_reserve(struct op_entry *entry,
> -			    struct pt_regs * const regs,
> -			    unsigned long pc, int code, int size);
> -int oprofile_add_data(struct op_entry *entry, unsigned long val);
> -int oprofile_add_data64(struct op_entry *entry, u64 val);
> -int oprofile_write_commit(struct op_entry *entry);
> -
> -#ifdef CONFIG_HW_PERF_EVENTS
> -int __init oprofile_perf_init(struct oprofile_operations *ops);
> -void oprofile_perf_exit(void);
> -char *op_name_from_perf_id(void);
> -#else
> -static inline int __init oprofile_perf_init(struct oprofile_operations *ops)
> -{
> -	pr_info("oprofile: hardware counters not available\n");
> -	return -ENODEV;
> -}
> -static inline void oprofile_perf_exit(void) { }
> -#endif /* CONFIG_HW_PERF_EVENTS */
> -
> -#endif /* OPROFILE_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index b77c60f8b963..03eb36256405 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2024,7 +2024,7 @@ config PROFILING
>  	bool "Profiling support"
>  	help
>  	  Say Y here to enable the extended profiling support mechanisms used
> -	  by profilers such as OProfile.
> +	  by profilers.
>  
>  #
>  # Place an empty function call at each tracepoint site. Can be
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 
