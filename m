Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F231AC433EF
	for <rcu@archiver.kernel.org>; Mon, 20 Jun 2022 23:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345884AbiFTXAD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345971AbiFTW7q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jun 2022 18:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4E193CB;
        Mon, 20 Jun 2022 15:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AEBB61386;
        Mon, 20 Jun 2022 22:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24B5C341C5;
        Mon, 20 Jun 2022 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765899;
        bh=ARfTLraENreDI3aXHqN2Q2vPqJl9ICDQOObYFORuh0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlxO9EW5HDLBE0BH3Q5VepI+4aXq9hvoanw4hkLk67LdvQH+911nRKKYTzQeNIDEW
         WyucsW/A2MWeFHss0c+yqwM+6XWPPKHSJUpuIZ1ga5D9HwQi3DZoIbxnpT04iB2Kl4
         2OMojBvLIEw1uMvkEQWJiy7HhlrktmdBz3dq9sO0CZ6YyNUtQQl4vnNE91SIaEMPqe
         2rPGcSDfyHNPfJGLK23Fs8hTiESkoJvbO3up9rahfDB3RYGt5WhaW/X3MW9IN3NWtv
         F6Kemyx31KEnNkuG21Px+73PC/uEylwlB3RLzzMuz81jNvyVuKrZuExarqWBaQD4Hz
         8hv+EflaiqfGg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9DB985C0ADC; Mon, 20 Jun 2022 15:58:19 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/12] torture: Adjust to again produce debugging information
Date:   Mon, 20 Jun 2022 15:58:10 -0700
Message-Id: <20220620225817.3843106-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225814.GA3842995@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

A recent change to the DEBUG_INFO Kconfig option means that simply adding
CONFIG_DEBUG_INFO=y to the .config file and running "make oldconfig" no
longer works.  It is instead necessary to add CONFIG_DEBUG_INFO_NONE=n
and (for example) CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y.
This combination will then result in CONFIG_DEBUG_INFO being selected.

This commit therefore updates the Kconfig options produced in response
to the kvm.sh --gdb, --kasan, and --kcsan Kconfig options.

Fixes: f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from a choice")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 263e16aeca0e4..6c734818a8757 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -164,7 +164,7 @@ do
 		shift
 		;;
 	--gdb)
-		TORTURE_KCONFIG_GDB_ARG="CONFIG_DEBUG_INFO=y"; export TORTURE_KCONFIG_GDB_ARG
+		TORTURE_KCONFIG_GDB_ARG="CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y"; export TORTURE_KCONFIG_GDB_ARG
 		TORTURE_BOOT_GDB_ARG="nokaslr"; export TORTURE_BOOT_GDB_ARG
 		TORTURE_QEMU_GDB_ARG="-s -S"; export TORTURE_QEMU_GDB_ARG
 		;;
@@ -180,7 +180,7 @@ do
 		shift
 		;;
 	--kasan)
-		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
+		TORTURE_KCONFIG_KASAN_ARG="CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y CONFIG_KASAN=y"; export TORTURE_KCONFIG_KASAN_ARG
 		if test -n "$torture_qemu_mem_default"
 		then
 			TORTURE_QEMU_MEM=2G
@@ -192,7 +192,7 @@ do
 		shift
 		;;
 	--kcsan)
-		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
+		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO_NONE=n CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y CONFIG_KCSAN=y CONFIG_KCSAN_STRICT=y CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
 	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
-- 
2.31.1.189.g2e36527f23

