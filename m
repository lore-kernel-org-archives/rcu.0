Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08055823DF;
	Fri, 16 Aug 2024 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723787604; cv=none; b=NGpUm7XLcSW1NXZnWpVz2I3llMUDjHykErCdzMItrVnFVa/iYXrd7qcAvL/pGm4MbpW3L+ioCwLuQIZ8ixtBmXIHzraquHjuLs/OdHwlxWlrc9vrLE8leqZ/i3O0WnbS9kWQNoLekeIIF6DCi5dwtTEdKg2jG6MHnid/NqMhGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723787604; c=relaxed/simple;
	bh=CYu7Ctlkux75sJ6jQTgFF9TptqNclQ2VfjFauJ+V82k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPAT4hSfCjqA88/3T6RFwCan4E0PahWuRvHECXWEck6A9l3QA0rgaLUzh/3pTeh4qG3ZD875wGPrqp91yK6v14DeME2fXJrKnfis1sNVZGyIvBCM1Ibc8bCbnFgm5/AyrBPKXskXncXQ7Qx3dxVMIkTfEfj67MC0ehbkRvN3LOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CToieIgR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CToieIgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D44C4AF0B;
	Fri, 16 Aug 2024 05:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723787603;
	bh=CYu7Ctlkux75sJ6jQTgFF9TptqNclQ2VfjFauJ+V82k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CToieIgR9NhQRrOXB0CVHKqwu+taG0VgWsSPgRz7Y8FOJ5HRpy6INHW3lk8WfLy59
	 TEqpa8Fv+NAMQO0qX/9IPAm7meQ2rR2zNfJWPjt23jdtATJFjgoONxHiB0oxu5tMX7
	 pLDeRewaJsJtvvaJT4IThLXSCWg2m0Df6/TeWPhBHapKEW/FVXIvAjbs+Irc+Dl4yN
	 TlSfAF1VAKzLiLhO3W9F8nh4iR62zThZcOPlUymrzrXdmKTd4CHttDPpJWzrhGyxk1
	 pflwmUotOVppbgBLwK7BjcUtNIS3b9HXy5bery7XOiVpap/HNO6lIa4n1OGkE1l8EH
	 rrYTsT3eg80rw==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH rcu 4/8] rcutorture: Add CFcommon.arch for arch-specific Kconfig options
Date: Fri, 16 Aug 2024 11:21:59 +0530
Message-Id: <20240816055203.43784-5-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
References: <20240816055203.43784-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

Add CFcommon.arch for arch-specific Kconfig options.

In accordance with [1], [2] and [3], move the x86-specific kernel option
CONFIG_HYPERVISOR_GUEST to CFcommon.i686 and CFcommon.x86_64, and also
move the x86/PowerPC CONFIG_KVM_GUEST Kconfig option to CFcommon.i686,
CFcommon.x86_64, and CFcommon.ppc64le.

The "arch" in CFcommon.arch is taken from the "uname -m" command.

[1] https://lore.kernel.org/all/20240427005626.1365935-1-zhouzhouyi@gmail.com/
[2] https://lore.kernel.org/all/059d36ce-6453-42be-a31e-895abd35d590@paulmck-laptop/
[3] https://lore.kernel.org/all/ZnBkHosMDhsh4H8g@J2N7QTR9R3/

Tested in x86_64 and PPC VM of Open Source Lab of Oregon State University.

Fixes: a6fda6dab93c ("rcutorture: Tweak kvm options")
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh        | 2 ++
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon         | 2 --
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686    | 2 ++
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le | 1 +
 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64  | 2 ++
 5 files changed, 7 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b33cd8753689..ad79784e552d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -68,6 +68,8 @@ config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
 config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
 config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
+config_override_param "$config_dir/CFcommon.$(uname -m)" KcList \
+		      "`cat $config_dir/CFcommon.$(uname -m) 2> /dev/null`"
 cp $T/KcList $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
index 0e92d85313aa..217597e84905 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -1,7 +1,5 @@
 CONFIG_RCU_TORTURE_TEST=y
 CONFIG_PRINTK_TIME=y
-CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
-CONFIG_KVM_GUEST=y
 CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n
 CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
new file mode 100644
index 000000000000..d8b2f555686f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.i686
@@ -0,0 +1,2 @@
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_KVM_GUEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
new file mode 100644
index 000000000000..133da04247ee
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.ppc64le
@@ -0,0 +1 @@
+CONFIG_KVM_GUEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64 b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
new file mode 100644
index 000000000000..d8b2f555686f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon.x86_64
@@ -0,0 +1,2 @@
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_KVM_GUEST=y
-- 
2.40.1

