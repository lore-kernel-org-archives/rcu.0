Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844079;
	b=I4UB3g2jdB7LkkVSyOUBQc9A6IRVFJ9TQjZpFwhsGj0fmcy0RTx8ui4JUECEOgDkYvOQ
	 lOpDcW1bIEb48x2Ap9RhY9lfG4LdTfdrPUColSJ+hOro53gA6RywIylURa4gOoyAucJVM
	 M369bSsgJfq082DT/gXGAZ6iQN9a+NjgW+omAdof0P/gbq6r72fs7EQBK/o1Yp4FPusna
	 M0WA36YUxDyKxAFEXRm0JH+kt+ZNrVogZ6Itt+WhVAZBEkGzfODiJ2ffAw+p9VBjNDtTi
	 m+8JM0pGYzS6uMUWpv7+Dl9owMSVsNq1N9Gcyq/JIsMN9O2SSqBLk493EaeAoHO+IQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844079;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=MrykgqblsgkTBBhZT90jYeBND9vd1pcgeJZVOE7ReYk=;
	b=nMx6o1clV6Eu4rSRLqzOLH7XDyfVORJsoWlnW9MMpZ1k5w4XnO3SrMEK/m3rmX2r8wW+
	 XFdd2w/gUiE1U+OnpnnMyVnB6YzxSMgsBrVHbeDkBK9q6vd9i/dgVwcY5aqw4X/79CJbv
	 mHY+Hkc/ThKz6yqxGGG/iBnZVRuVUs2iWZqwKjdYLU0/Cd/srpOHWxHMmbAgUcZ3XE+SR
	 jojc220tw64CNzdu2ec2VqCtOiIULm2RnHPeGdUjQhDbY+Mp4ndAt0eEwbmlkBql8jR3V
	 TEZRaofQvgzI5YepMLzB7O5yWOYnL0tkTqIQ/zWbTDhUsgu0Or9G0PsEGJ5cLrWsgZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=E89PU2Po;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE16606EEA7;
	Thu,  5 Nov 2026 02:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE16606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=E89PU2Po
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MrykgqblsgkTBBhZT90jYeBND9vd1pcgeJZVOE7ReYk=; b=E89PU2Po5NQYe57K5iPKPyxkd6
	EIFv08iZkTq/YiSNs1ncnEO5K7DjkjDC3IC3NUTXGYeevXC0fQe4r9thR/oKu5IlQI0WlB9Qya8Te
	c7HrdPPF7zjoVGaa1EdF2FXEIHGmKdWODQsWFXfDNJTHa9r7nGsIGk7ZzsJEd0OxHB05SGUOKuNY2
	aO4pJCl+2mJm5TNBhuBw3aGVvpsgp8T6pvG6ZV3zOsLyZd35My2L1XELY+FzEO+30p1n9YNHMqTGp
	IuqlM18MEWRI7Dxy7omuWMw4q7MP3LDMfJDqlmEq/N1IFs6dMk4FApecH+BxctBp15fmddZD8tWGx
	BKPpjO/A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmo-00000002ROP-25S4;
	Thu, 05 Nov 2026 02:01:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDu-3GYz;
	Thu, 05 Nov 2026 02:01:04 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 14/20] KVM: selftests: Add nested VMX APIC cache invalidation test
Date: Thu,  5 Nov 2026 02:00:56 +0000
Message-ID: <20261105020104.2507083-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105020104.2507083-1-dwmw2@infradead.org>
References: <20261105020104.2507083-1-dwmw2@infradead.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: Fred Griffoul <fgriffo@amazon.co.uk>

Add a selftest for the nested VMX APIC page caches: an L2 guest
writes the APIC-access page while a second thread repeatedly
invalidates the underlying mapping, either with
madvise(MADV_DONTNEED) (MMU notifier path) or by moving the memslot
away and back (memslot update path), so the GPA under test is
repeatedly unbacked and re-latched.

The test asserts that L2 keeps running across the invalidations with
no guest-visible errors, that at least one invalidation actually ran
concurrently, and that the access only ever bounces to userspace as
MMIO in the memslot-move variant (while the slot is moved away the
GPA is unbacked; madvise never unbacks the GPA, so an MMIO exit
there means KVM lost the mapping).

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>

[dwmw2: Adapt to selftest API drift since the v4 posting: prepare_vmcs()
        no longer takes an L2 stack (4c396f19de5d), vm_vaddr_t is now
        gva_t, and the prepare_eptp()/nested_map*() EPT helpers were
        replaced by vm_enable_tdp()/tdp_map()/
        tdp_identity_map_default_memslots().]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/vmx_apic_update_test.c  | 323 ++++++++++++++++++
 2 files changed, 324 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/vmx_apic_update_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..dcfe815f4a02 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -161,6 +161,7 @@ TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
 TEST_GEN_PROGS_x86 += x86/guest_memfd_conversions_test
+TEST_GEN_PROGS_x86 += x86/vmx_apic_update_test
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c b/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
new file mode 100644
index 000000000000..357e10c88cd0
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vmx_apic_update_test.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vmx_apic_update_test
+ *
+ * Copyright (C) 2025, Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Test L2 guest APIC access page writes with concurrent MMU
+ * notification and memslot move updates.
+ */
+#include <limits.h>
+#include <pthread.h>
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "vmx.h"
+
+#define VAPIC_GPA	0xc0000000
+#define VAPIC_SLOT	1
+
+
+#define L2_DELAY	(100)
+
+static void l2_guest_code(void)
+{
+	uint32_t *vapic_addr = (uint32_t *) (VAPIC_GPA + 0x80);
+
+	/* Unroll the loop to avoid any compiler side effect */
+
+	WRITE_ONCE(*vapic_addr, 1 << 0);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 1);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 2);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 3);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 4);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 5);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 1 << 6);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	WRITE_ONCE(*vapic_addr, 0);
+	udelay(msecs_to_usecs(L2_DELAY));
+
+	/* Exit to L1 */
+	vmcall();
+}
+
+static void l1_guest_code(struct vmx_pages *vmx_pages)
+{
+	uint32_t control, exit_reason;
+
+	prepare_for_vmx_operation(vmx_pages);
+	load_vmcs(vmx_pages);
+	prepare_vmcs(vmx_pages, l2_guest_code);
+
+	/* Enable APIC access */
+	control = vmread(CPU_BASED_VM_EXEC_CONTROL);
+	control |= CPU_BASED_ACTIVATE_SECONDARY_CONTROLS;
+	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
+	control = vmread(SECONDARY_VM_EXEC_CONTROL);
+	control |= SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES;
+	vmwrite(SECONDARY_VM_EXEC_CONTROL, control);
+	vmwrite(APIC_ACCESS_ADDR, VAPIC_GPA);
+
+	GUEST_SYNC1(0);
+	vmlaunch();
+again:
+	exit_reason = vmread(VM_EXIT_REASON);
+	if (exit_reason == EXIT_REASON_APIC_ACCESS) {
+		uint64_t guest_rip = vmread(GUEST_RIP);
+		uint64_t instr_len = vmread(VM_EXIT_INSTRUCTION_LEN);
+
+		vmwrite(GUEST_RIP, guest_rip + instr_len);
+		vmresume();
+		goto again;
+	}
+
+	GUEST_SYNC1(exit_reason);
+	GUEST_ASSERT(exit_reason == EXIT_REASON_VMCALL);
+	GUEST_DONE();
+}
+
+static const char *progname;
+static int update_period_ms = L2_DELAY / 4;
+
+struct update_control {
+	pthread_mutex_t mutex;
+	pthread_cond_t start_cond;
+	struct kvm_vm *vm;
+	bool running;
+	bool started;
+	int updates;
+};
+
+static void wait_for_start_signal(struct update_control *ctrl)
+{
+	pthread_mutex_lock(&ctrl->mutex);
+	while (!ctrl->started)
+		pthread_cond_wait(&ctrl->start_cond, &ctrl->mutex);
+
+	pthread_mutex_unlock(&ctrl->mutex);
+	printf("%s: starting update\n", progname);
+}
+
+static bool is_running(struct update_control *ctrl)
+{
+	return READ_ONCE(ctrl->running);
+}
+
+static void set_running(struct update_control *ctrl, bool running)
+{
+	WRITE_ONCE(ctrl->running, running);
+}
+
+static void signal_thread_start(struct update_control *ctrl)
+{
+	pthread_mutex_lock(&ctrl->mutex);
+	if (!ctrl->started) {
+		ctrl->started = true;
+		pthread_cond_signal(&ctrl->start_cond);
+	}
+	pthread_mutex_unlock(&ctrl->mutex);
+}
+
+static void *update_madvise(void *arg)
+{
+	struct update_control *ctrl = arg;
+	void *hva;
+
+	wait_for_start_signal(ctrl);
+
+	hva = addr_gpa2hva(ctrl->vm, VAPIC_GPA);
+	memset(hva, 0x45, ctrl->vm->page_size);
+
+	while (is_running(ctrl)) {
+		usleep(update_period_ms * 1000);
+		madvise(hva, ctrl->vm->page_size, MADV_DONTNEED);
+		ctrl->updates++;
+	}
+
+	return NULL;
+}
+
+static void *update_move_memslot(void *arg)
+{
+	struct update_control *ctrl = arg;
+	uint64_t gpa = VAPIC_GPA;
+
+	wait_for_start_signal(ctrl);
+
+	/*
+	 * Alternate the slot between VAPIC_GPA and an alternate address,
+	 * so that the GPA under test is repeatedly unbacked (L2's APIC
+	 * access bounces to userspace as MMIO) and re-backed (KVM must
+	 * re-latch the page). Moving strictly away would change
+	 * vCPU-visible state only once.
+	 */
+	while (is_running(ctrl)) {
+		usleep(update_period_ms * 1000);
+		gpa = (gpa == VAPIC_GPA) ? VAPIC_GPA + 0x10000 : VAPIC_GPA;
+		vm_mem_region_move(ctrl->vm, VAPIC_SLOT, gpa);
+		ctrl->updates++;
+	}
+
+	return NULL;
+}
+
+static void run(void * (*update)(void *), const char *name, bool mmio_ok)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct update_control ctrl;
+	struct ucall uc;
+	gva_t vmx_pages_gva;
+	pthread_t update_thread;
+	bool done = false;
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	/* Set up nested EPT */
+	vm_enable_tdp(vm);
+
+	/* Allocate VMX pages */
+	vcpu_alloc_vmx(vm, &vmx_pages_gva);
+
+	/* Allocate memory and create VAPIC memslot */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, VAPIC_GPA,
+				    VAPIC_SLOT, 1, 0);
+
+	/* Allocate guest page table */
+	virt_map(vm, VAPIC_GPA, VAPIC_GPA, 1);
+
+	/* Identity-map everything, including the VAPIC page, in the EPT */
+	tdp_identity_map_default_memslots(vm);
+	tdp_map(vm, VAPIC_GPA, VAPIC_GPA, vm->page_size);
+
+	vcpu_args_set(vcpu, 1, vmx_pages_gva);
+
+	pthread_mutex_init(&ctrl.mutex, NULL);
+	pthread_cond_init(&ctrl.start_cond, NULL);
+	ctrl.vm = vm;
+	ctrl.running = true;
+	ctrl.started = false;
+	ctrl.updates = 0;
+
+	kvm_pthread_create(&update_thread, NULL, update, &ctrl);
+
+	printf("%s: running %s (tsc_khz %lu)\n", progname, name, guest_tsc_khz);
+
+	while (!done) {
+		vcpu_run(vcpu);
+
+		switch (vcpu->run->exit_reason) {
+		case KVM_EXIT_IO:
+			switch (get_ucall(vcpu, &uc)) {
+			case UCALL_SYNC:
+				printf("%s: sync(%ld)\n", progname, uc.args[0]);
+				if (uc.args[0] == 0)
+					signal_thread_start(&ctrl);
+				break;
+			case UCALL_ABORT:
+				REPORT_GUEST_ASSERT(uc);
+				/* NOT REACHED */
+			case UCALL_DONE:
+				done = true;
+				break;
+			default:
+				TEST_ASSERT(false, "Unknown ucall %lu", uc.cmd);
+			}
+			break;
+		case KVM_EXIT_MMIO:
+			/*
+			 * While the slot is moved away, the GPA under test
+			 * is unbacked and the access legitimately bounces
+			 * to userspace as MMIO (until the updater moves it
+			 * back). madvise() never unbacks the GPA, so there
+			 * an MMIO exit means KVM lost the mapping: fail.
+			 */
+			TEST_ASSERT(mmio_ok,
+				    "%s: unexpected APIC MMIO access at 0x%llx",
+				    progname, vcpu->run->mmio.phys_addr);
+			printf
+			    ("%s: APIC MMIO access at 0x%llx (memslot move effect)\n",
+			     progname, vcpu->run->mmio.phys_addr);
+			break;
+		default:
+			TEST_FAIL("%s: Unexpected exit reason: %d (flags 0x%x)",
+				  progname,
+				  vcpu->run->exit_reason, vcpu->run->flags);
+		}
+	}
+
+	set_running(&ctrl, false);
+	if (!ctrl.started)
+		signal_thread_start(&ctrl);
+	kvm_pthread_join(update_thread, NULL);
+	printf("%s: completed with %d updates\n", progname, ctrl.updates);
+	TEST_ASSERT(ctrl.updates > 0,
+		    "%s: %s performed no updates; nothing was tested",
+		    progname, name);
+
+	pthread_mutex_destroy(&ctrl.mutex);
+	pthread_cond_destroy(&ctrl.start_cond);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt_madvise = 0;
+	int opt_memslot_move = 0;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_cpu_has_ept());
+
+	if (argc == 1) {
+		opt_madvise = 1;
+		opt_memslot_move = 1;
+	} else {
+		int opt;
+
+		while ((opt = getopt(argc, argv, "amp:")) != -1) {
+			switch (opt) {
+			case 'a':
+				opt_madvise = 1;
+				break;
+			case 'm':
+				opt_memslot_move = 1;
+				break;
+			case 'p':
+				update_period_ms = atoi(optarg);
+				TEST_ASSERT(update_period_ms > 0 &&
+					    update_period_ms < INT_MAX / 1000,
+					    "Update period must be a positive number of milliseconds, not '%s'",
+					    optarg);
+				break;
+			default:
+				exit(1);
+			}
+		}
+	}
+
+	TEST_ASSERT(opt_madvise
+		    || opt_memslot_move, "No update test configured");
+
+	progname = argv[0];
+
+	if (opt_madvise)
+		run(update_madvise, "madvise", false);
+
+	if (opt_memslot_move)
+		run(update_move_memslot, "move memslot", true);
+
+	return 0;
+}
-- 
2.43.0

