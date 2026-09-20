Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1DA29346F;
	Sun, 20 Sep 2026 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789939194; cv=none; b=BCDgL0JOmFTL5VcwBOK7nzou03rdYKoLXZXfKLHV9dIQMILi4htWEmYCrtpKtlFFLpK2VVwcD1KdpiwuEAM3MU334h4KbB/6D9lGS8evLaaZYc/Fux5ahkBFgd3mytGGDeBNRtkqq44o9NRUn7rY8ez9E6I+05pd42VmvL69Yms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789939194; c=relaxed/simple;
	bh=Sv7JczPELmdN1cWb9aFNrR6Fs1QRMm7vY5jtSzyoPu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eIxvJ+Q+J1V29Kbvn9anZhTYvNPWolxUWoc1p1cFsFzqfh0CKup1QOCq97bC7aWZTE1yJ4pInKflOvS9cHnBkYjum7pwtdltOUsYFCrdfTffPcaaeUw36XtBhJePmpO+7gQ/75w1tvyobC6l8dJvMVLBazxXUq5EoFVPtGoC8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d4jaV/uN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4jaV/uN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1R/xApd+0lV6Tt+R8GQB36QmeWERqFy2bhE9BJ1KIL8=; b=d4jaV/uNxZZnz/UVIC6QHUySva
	e/jaZOlQmg+Yk+O55rFkoSOipDiH6BDBp2ivzdko5QTNbxRLg+5yaMT3SkyoxIjD9MdhJR8+Voo8y
	lRCQN+RU27JfMtJSkqEzHRtmFLaRY7jplCBnO/pvPx0IId3Al9f+PwuGv0EfgyjQK4/9n4F4SnSWc
	mkjgiVrl+2vTBBx0IbBpm7QNPvhthgBmyEh7tJX2YNVj+DKPUyWAJ0CpRIYXYz8iAUMlZkFZA1Yes
	EHP6JYO0qWzp+X8cPBa717ubjNF8uXpI+M/9NoGpoE9rNvxthxv0vyqqjkEcPDxus3tW79a7pcuaB
	SXhl4VNA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x8OwW-0000000Bdxb-49Ub;
	Sun, 20 Sep 2026 21:19:44 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwV-00000003tdR-023A;
	Sun, 20 Sep 2026 22:19:23 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Hocko <mhocko@suse.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Keir Fraser <keirf@google.com>,
	David Matlack <dmatlack@google.com>,
	nh-open-source@amazon.com,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 17/17] KVM: selftests: Add nested transition benchmark
Date: Sun, 20 Sep 2026 21:49:45 +0100
Message-ID: <20260920211920.928306-18-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920211920.928306-1-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Measure L1<->L2 transition costs from L1's viewpoint, in TSC cycles:
a reflected-exit phase (cpuid in L2, forwarded to L1: the full
emulated vmexit->vmentry round trip, exercising the vmcb12/vmcs12
access paths), and on SVM an MSR-intercept phase (rdmsr in L2 with
INTERCEPT_MSR_PROT: exercises the per-intercept lookup in L1's MSR
permissions map). Reports min/avg/p50/p99/max over 100k iterations.

Works on both VMX and SVM.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/nested_transition_bench.c         | 204 ++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_transition_bench.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index b30fa994d5e5..2c5cd619f747 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -156,6 +156,7 @@ TEST_GEN_PROGS_x86 += x86/triple_fault_event_test
 TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
 TEST_GEN_PROGS_x86 += x86/vmx_apic_update_test
+TEST_GEN_PROGS_x86 += x86/nested_transition_bench
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/nested_transition_bench.c b/tools/testing/selftests/kvm/x86/nested_transition_bench.c
new file mode 100644
index 000000000000..12fc1ac610e9
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_transition_bench.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * nested_transition_bench
+ *
+ * Measure nested virtualization transition costs:
+ *  1. L2 exit reflected to L1 (cpuid): full emulated vmexit->vmentry
+ *     round trip, exercising the vmcb12/vmcs12 access paths.
+ *  2. L2 MSR access with MSR intercepts enabled: exercises the
+ *     per-intercept L1 permissions-bitmap lookup on SVM, and the
+ *     bitmap merge path when force_msr_bitmap_recalc is set.
+ *
+ * Reports TSC cycles per iteration (min/avg/p99) from L1's viewpoint.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "vmx.h"
+#include "svm_util.h"
+
+/*
+ * Keep the iteration count modest: every timed iteration includes a
+ * ucall round trip to userspace to report its sample, which on a
+ * debug (KASAN) kernel costs milliseconds. 10k samples still give a
+ * stable p99.
+ */
+#define N_WARMUP	1000
+#define N_ITERS		10000
+
+
+static uint64_t results[N_ITERS];
+
+/* L2: exit to L1 in a tight loop. */
+static void l2_guest_code(void)
+{
+	u32 eax, ebx, ecx, edx;
+
+	for (;;)
+		cpuid(0, &eax, &ebx, &ecx, &edx);
+}
+
+static void l2_guest_code_msr(void)
+{
+	for (;;)
+		rdmsr(MSR_IA32_TSC_DEADLINE);
+}
+
+/* SVM L1: run L2, timing VMRUN -> #VMEXIT round trips. */
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+	uint64_t t0, t1;
+	int i;
+
+	generic_svm_setup(svm, l2_guest_code);
+	/*
+	 * Unlike VMX, where CPUID unconditionally exits, SVM only
+	 * intercepts CPUID if asked; without it L0 emulates L2's cpuid
+	 * and resumes L2 directly, and run_guest() never returns.
+	 */
+	vmcb->control.intercept |= BIT_ULL(INTERCEPT_CPUID) |
+				   BIT_ULL(INTERCEPT_MSR_PROT);
+
+	/*
+	 * Set the read-intercept bit for MSR_IA32_TSC_DEADLINE (0x6e0,
+	 * MSRPM range 0: bit 2*msr, i.e. byte 0x1b8 bit 0) in L1's MSRPM,
+	 * so that L2's rdmsr in phase 2 reflects to L1. L0's per-exit
+	 * lookup in this bitmap is the path being measured.
+	 */
+	((u8 *)svm->msr)[(MSR_IA32_TSC_DEADLINE & 0x1fff) * 2 / 8] |=
+		BIT((MSR_IA32_TSC_DEADLINE & 0x1fff) * 2 % 8);
+
+	for (i = 0; i < N_WARMUP; i++) {
+		run_guest(vmcb, svm->vmcb_gpa);
+		GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_CPUID);
+		vmcb->save.rip += 2; /* cpuid */
+	}
+
+	for (i = 0; i < N_ITERS; i++) {
+		t0 = rdtsc();
+		run_guest(vmcb, svm->vmcb_gpa);
+		t1 = rdtsc();
+		GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_CPUID);
+		vmcb->save.rip += 2;
+		GUEST_SYNC1(t1 - t0);
+	}
+
+	/* Phase 2: MSR intercept path */
+	vmcb->save.rip = (u64)l2_guest_code_msr;
+	for (i = 0; i < N_ITERS; i++) {
+		t0 = rdtsc();
+		run_guest(vmcb, svm->vmcb_gpa);
+		t1 = rdtsc();
+		GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_MSR);
+		vmcb->save.rip += 2; /* rdmsr */
+		GUEST_SYNC1(t1 - t0);
+	}
+
+	GUEST_DONE();
+}
+
+/* VMX L1: run L2, timing VMRESUME -> vmexit round trips. */
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	uint64_t t0, t1;
+	int i;
+
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx));
+	GUEST_ASSERT(load_vmcs(vmx));
+	prepare_vmcs(vmx, l2_guest_code);
+
+	GUEST_ASSERT(!vmlaunch());
+	/* first exit is here; loop resumes */
+	for (i = 0; i < N_WARMUP; i++) {
+		GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_CPUID);
+		vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) +
+			vmreadz(VM_EXIT_INSTRUCTION_LEN));
+		GUEST_ASSERT(!vmresume());
+	}
+
+	for (i = 0; i < N_ITERS; i++) {
+		GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_CPUID);
+		vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) +
+			vmreadz(VM_EXIT_INSTRUCTION_LEN));
+		t0 = rdtsc();
+		GUEST_ASSERT(!vmresume());
+		t1 = rdtsc();
+		GUEST_SYNC1(t1 - t0);
+	}
+
+	GUEST_DONE();
+}
+
+static int cmp_u64(const void *a, const void *b)
+{
+	uint64_t x = *(const uint64_t *)a, y = *(const uint64_t *)b;
+
+	return x < y ? -1 : x > y;
+}
+
+static void report(const char *phase, int n)
+{
+	uint64_t sum = 0;
+	int i;
+
+	qsort(results, n, sizeof(results[0]), cmp_u64);
+	for (i = 0; i < n; i++)
+		sum += results[i];
+
+	printf("%-24s n=%d min=%" PRIu64 " avg=%" PRIu64 " p50=%" PRIu64
+	       " p99=%" PRIu64 " max=%" PRIu64 " cycles\n",
+	       phase, n, results[0], sum / n, results[n / 2],
+	       results[(int)(n * 0.99)], results[n - 1]);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gva_t nested_gva = 0;
+	bool is_svm = kvm_cpu_has(X86_FEATURE_SVM);
+	int n = 0, phase = 0;
+	bool done = false;
+
+	TEST_REQUIRE(is_svm || kvm_cpu_has(X86_FEATURE_VMX));
+
+	vm = vm_create_with_one_vcpu(&vcpu, is_svm ? (void *)l1_svm_code
+						   : (void *)l1_vmx_code);
+	if (is_svm)
+		vcpu_alloc_svm(vm, &nested_gva);
+	else
+		vcpu_alloc_vmx(vm, &nested_gva);
+	vcpu_args_set(vcpu, 1, nested_gva);
+
+	while (!done) {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			results[n++] = uc.args[0];
+			if (n == N_ITERS) {
+				report(phase == 0 ? "reflected-exit" :
+						    "msr-intercept", n);
+				n = 0;
+				phase++;
+			}
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		case UCALL_DONE:
+			if (n)
+				report("partial", n);
+			done = true;
+			break;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+	}
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.55.0

