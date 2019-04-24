Return-Path: <SRS0=IIpI=S2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3E8C10F11
	for <rcu@archiver.kernel.org>; Wed, 24 Apr 2019 07:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2313D218B0
	for <rcu@archiver.kernel.org>; Wed, 24 Apr 2019 07:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfDXHe7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:34:59 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52319 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbfDXHe7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Apr 2019 03:34:59 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hJCQg-0001zW-4X; Wed, 24 Apr 2019 09:34:55 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kselftest@vger.kernel.org, rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] rcutorture: Tweak kvm options
Date:   Wed, 24 Apr 2019 09:34:46 +0200
Message-Id: <20190424073446.8577-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In one of my rcutorture tests the TSC clocksource got marked unstable
due to a large difference in the TSC value. I'm not sure if the guest
run for a long time with disabled interrupts or if the host was very
busy and didn't schedule the guest for some time.
I took a look on the qemu/KVM options and decided to update the options:
- Use kvm{32|64} as CPU. We could probably use `host' (like ARM does)
  for maximum available features but since we don't run any userland I'm
  not sure if it makes any difference.

- Drop the "noapic" option, enable TSC deadline timer. There is no
  history why the APIC was disabled, I see no reason for it. The
  deadline timer is probably "nicer".

- Additional config options. It ensures that the kernel knowns that it
  runs as a kvm guest and can use virt devices like the kvm-clock as
  clocksource. The kvm-clock was the main motivation here.

- I didn't add a random HW device. It would make the random device ready
  earlier (not it doesn't complete the initialisation at all) but I
  doubt that there is any need for this.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 13 ++++++++++++-
 .../selftests/rcutorture/configs/rcu/CFcommon       |  4 ++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 6bcb8b5b2ff22..be3c5c73d7e79 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -172,7 +172,7 @@ identify_qemu_append () {
 	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
-		echo noapic selinux=0 initcall_debug debug
+		echo selinux=0 initcall_debug debug
 		;;
 	qemu-system-aarch64)
 		console=ttyAMA0
@@ -191,8 +191,19 @@ identify_qemu_append () {
 # Output arguments for qemu arguments based on the TORTURE_QEMU_MAC
 # and TORTURE_QEMU_INTERACTIVE environment variables.
 identify_qemu_args () {
+	local KVM_CPU=""
+	case "$1" in
+	qemu-system-x86_64)
+		KVM_CPU=kvm64
+		;;
+	qemu-system-i386)
+		KVM_CPU=kvm32
+		;;
+	esac
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
+		echo -machine q35,accel=kvm
+		echo -cpu ${KVM_CPU},x2apic=on,tsc-deadline=on,hypervisor=on,tsc_adjust=on
 		;;
 	qemu-system-aarch64)
 		echo -machine virt,gic-version=host -cpu host
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
index d2d2a86139db1..322d5d40443cd 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFcommon
@@ -1,2 +1,6 @@
 CONFIG_RCU_TORTURE_TEST=y
 CONFIG_PRINTK_TIME=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_PARAVIRT_SPINLOCKS=y
+CONFIG_KVM_GUEST=y
-- 
2.20.1

