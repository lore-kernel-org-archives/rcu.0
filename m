Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5C6C433DB
	for <rcu@archiver.kernel.org>; Wed,  3 Feb 2021 23:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE58764F61
	for <rcu@archiver.kernel.org>; Wed,  3 Feb 2021 23:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhBCXvf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Feb 2021 18:51:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhBCXvd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Feb 2021 18:51:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 256AC64F53;
        Wed,  3 Feb 2021 23:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612396252;
        bh=zFHFv+P1s0q4JfWyuoNofhrFvUPvSPhG+YxTpGNRHrs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=UQcJ1lnzBu7sB9H8DQ50AMNJpESAW45D8xNSxow5XzBqw/i/XFXXUcd7EE69TrEY0
         U+PkbidENcDikZdN56h4F7k2FGbS+q0PLk1Rh5IErcmu9jgBDWD+S1QzNoAy2xESPt
         dm0YTizO1jeL/eIHOMuj3/bEmQMsoGU/9Jk8drBc8AT4LMOgPsDe4nEYkmXe4Uizw+
         APSDZ9rV7N5nAnY6Dve1ncEMq67H9xNZh/8pozQ4fTHflFqJnq1APvWbeY6t0i4Uqz
         6895W5A/gDTCLrLW4C/7E5e7rxuso5uTUr8/BqNBTFt5ZgXqt80AfKQyN1a8nkGNQT
         rUTt8HxdhyXpQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BF43335226F1; Wed,  3 Feb 2021 15:50:51 -0800 (PST)
Date:   Wed, 3 Feb 2021 15:50:51 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Bare-metal rcutorture testing
Message-ID: <20210203235051.GA7481@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello, Frederic,

Based on our offlist discussion a few hours ago.  Thoughts?

						Thanx, Paul

------------------------------------------------------------------------

commit 0b76565136d4313218cdbdb20bb344e64348fc79
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Feb 3 15:44:29 2021 -0800

    torture: Provide bare-metal modprobe-based advice
    
    In some environments, the torture-testing use of virtualization is
    inconvenient.  In such cases, the modprobe and rmmod commands may be
    used to do torture testing, but significant setup is required to build,
    boot, and modprobe a kernel so as to match a given torture-test scenario.
    This commit therefore creates a "modprobe" file in each results directory
    containing steps to run the corresponding scenario using the modprobe
    command on bare metal.  For example, the contents of this file after
    using kvm.sh to build an rcutorture TREE01 kernel, perhaps with the
    --buildonly argument,  is as follows:
    
    To run this scenario on bare metal:
    1. Update your .config based on /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2021.02.03-15.10.09/TREE01/ConfigFragment.
    2. yes "" | make oldconfig
    3. Build your kernel.
    4. Boot with kernel parameters: maxcpus=8 nr_cpus=43 rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7
    5. modprobe rcutorture nocbs_nthreads=8 nocbs_toggle=1000 fwd_progress=0 onoff_interval=1000 onoff_holdoff=30 n_barrier_cbs=4 stat_interval=15 shutdown_secs=120 test_no_idle_hz=1 verbose=1
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 9d8a82c..08bcf66 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -7,15 +7,15 @@
 # Execute this in the source tree.  Do not run it as a background task
 # because qemu does not seem to like that much.
 #
-# Usage: kvm-test-1-run.sh config builddir resdir seconds qemu-args boot_args
+# Usage: kvm-test-1-run.sh config builddir resdir seconds qemu-args boot_args_in
 #
 # qemu-args defaults to "-enable-kvm -nographic", along with arguments
 #			specifying the number of CPUs and other options
 #			generated from the underlying CPU architecture.
-# boot_args defaults to value returned by the per_version_boot_params
+# boot_args_in defaults to value returned by the per_version_boot_params
 #			shell function.
 #
-# Anything you specify for either qemu-args or boot_args is appended to
+# Anything you specify for either qemu-args or boot_args_in is appended to
 # the default values.  The "-smp" value is deduced from the contents of
 # the config fragment.
 #
@@ -134,7 +134,7 @@ do
 done
 seconds=$4
 qemu_args=$5
-boot_args=$6
+boot_args_in=$6
 
 if test -z "$TORTURE_BUILDONLY"
 then
@@ -144,7 +144,7 @@ fi
 # Generate -smp qemu argument.
 qemu_args="-enable-kvm -nographic $qemu_args"
 cpu_count=`configNR_CPUS.sh $resdir/ConfigFragment`
-cpu_count=`configfrag_boot_cpus "$boot_args" "$config_template" "$cpu_count"`
+cpu_count=`configfrag_boot_cpus "$boot_args_in" "$config_template" "$cpu_count"`
 if test "$cpu_count" -gt "$TORTURE_ALLOTED_CPUS"
 then
 	echo CPU count limited from $cpu_count to $TORTURE_ALLOTED_CPUS | tee -a $resdir/Warnings
@@ -160,13 +160,25 @@ qemu_args="$qemu_args `identify_qemu_args "$QEMU" "$resdir/console.log"`"
 qemu_append="`identify_qemu_append "$QEMU"`"
 
 # Pull in Kconfig-fragment boot parameters
-boot_args="`configfrag_boot_params "$boot_args" "$config_template"`"
+boot_args="`configfrag_boot_params "$boot_args_in" "$config_template"`"
 # Generate kernel-version-specific boot parameters
 boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
 if test -n "$TORTURE_BOOT_GDB_ARG"
 then
 	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
 fi
+
+# Give bare-metal advice
+modprobe_args="`echo $boot_args | tr -s ' ' '\012' | grep "^$TORTURE_MOD\." | sed -e "s/$TORTURE_MOD\.//g"`"
+kboot_args="`echo $boot_args | tr -s ' ' '\012' | grep -v "^$TORTURE_MOD\."`"
+touch $resdir/modprobe
+echo To run this scenario on bare metal: >> $resdir/modprobe
+echo "1." Update your .config based on $resdir/ConfigFragment. >> $resdir/modprobe
+echo "2." 'yes "" | make oldconfig' >> $resdir/modprobe
+echo "3." Build your kernel. >> $resdir/modprobe
+echo "4." Boot with kernel parameters: $kboot_args >> $resdir/modprobe
+echo "5." modprobe $TORTURE_MOD $modprobe_args >> $resdir/modprobe
+
 echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
 echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
 echo "# seconds=$seconds" >> $resdir/qemu-cmd
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 8d3c99b..35a2132 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -29,6 +29,7 @@ PATH=${KVM}/bin:$PATH; export PATH
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
+TORTURE_BUILDONLY=
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_GDB_ARG=""
@@ -40,6 +41,7 @@ TORTURE_KMAKE_ARG=""
 TORTURE_QEMU_MEM=512
 TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
+TORTURE_MOD=rcutorture
 TORTURE_TRUST_MAKE=""
 resdir=""
 configs=""
@@ -215,6 +217,7 @@ do
 	--torture)
 		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuscale\|refscale\|scf\)$' '^--'
 		TORTURE_SUITE=$2
+		TORTURE_MOD="`echo $TORTURE_SUITE | sed -e 's/^\(lock\|rcu\|scf\)$/\1torture/'`"
 		shift
 		if test "$TORTURE_SUITE" = rcuscale || test "$TORTURE_SUITE" = refscale
 		then
@@ -381,6 +384,7 @@ TORTURE_QEMU_GDB_ARG="$TORTURE_QEMU_GDB_ARG"; export TORTURE_QEMU_GDB_ARG
 TORTURE_KCONFIG_KASAN_ARG="$TORTURE_KCONFIG_KASAN_ARG"; export TORTURE_KCONFIG_KASAN_ARG
 TORTURE_KCONFIG_KCSAN_ARG="$TORTURE_KCONFIG_KCSAN_ARG"; export TORTURE_KCONFIG_KCSAN_ARG
 TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG"; export TORTURE_KMAKE_ARG
+TORTURE_MOD="$TORTURE_MOD"; export TORTURE_MOD
 TORTURE_QEMU_CMD="$TORTURE_QEMU_CMD"; export TORTURE_QEMU_CMD
 TORTURE_QEMU_INTERACTIVE="$TORTURE_QEMU_INTERACTIVE"; export TORTURE_QEMU_INTERACTIVE
 TORTURE_QEMU_MAC="$TORTURE_QEMU_MAC"; export TORTURE_QEMU_MAC
