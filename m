Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844072;
	b=3qDyKL4AYhGASmvEBdEZPI3k9aTJ8QqdNhXV8TRBthyuKCSCJkR1AP8baZ/iRXIFE4aA
	 hEoNMkhL6kaFUqPw92ixfu6GeS0g++thsyBkU4FFdJ6mO/01bCbmFdLwKvOSXbPr6iEnU
	 B3qbMs9wZWmW+2tRWWEPaBt9U/Ru0koIjv5+h1kQzzax2cJhlWC8FR/pYZJnK2/U/Qu+H
	 cg/GJg2Hl3KFxVZZ0gQFVBBoAo9ukphZSPbutRu7cYTpU5RD7/ollyOlyz8qWoQQwgZNF
	 1uEYPM7EOvEETy3JaPT3ihO2HO+6dUPSHLWzV4ACYE1bPZ/1ItC03sqfIq5gdyp/vqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844072;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=ddwtYMIgIqYLX7L/896a+WHQ4S2b0Us6ZQUDCLv9brk=;
	b=uodMTTcF2XhoSte7/dCp9x1EkJIEWloiEdulk2M+GePN5/INJHYLv73YaXDLKCUoPY/8
	 4L42iqv+6rkGuvA/kSm/HQqGA1JG2Mc3hbYvpf+fWCHDQtgIH4hsch+SeIKADfS4RO93j
	 Gs0CxNugAuVtr+tUT2beit8sdnvUxGeOyMpALVylNai4mBrj+S7Lvpu5Zk8Yp6g/fYQns
	 aboXHh77VIDlaY7UBtCh2PTOD+2OFi1JKO+p3JwwuH9ujPe4B3hq0rvriOFYWZ8LY4aC5
	 P+HUW/35RvCrXy80bSWfeojccvtU45qxA0O3cKIOnya4stQYpylZlvl5cOuGETbE7+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ldzMubhh;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8D606A333;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA8D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ldzMubhh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ddwtYMIgIqYLX7L/896a+WHQ4S2b0Us6ZQUDCLv9brk=; b=ldzMubhhw0uNbJyP6Luvoz+z/6
	4rCLI8wrG8+4Cj8ACR1erqujTCctAjYU2yXzHNdeCNINWAyoeIB6a0g5hh3ek39ZM7a75EnY322AG
	sK8evPJu3ZKHflFM+gewOUPFXU65mJvn//HcYCbREolUjSi5Qt93c5f0JiBpS2z5TzypAjUiOWQqu
	qoc3xzvcU4Dd+y6VwCWk9T2wl7dnqHfBHJssZioPoC4fDUPckO78PMFrGZn/mj4q6vH3h8C9A57rX
	fRV5CzVjCgD2kg6uGqI4sFQR1U+8Tdmbc+9fLz8z4SmwEvnbPbjCxhp+aMPhcEGXNtZwh0cnhdy0w
	kw1mxWpA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037jT-2028;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWEA-480s;
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
Subject: [PATCH v2 18/20] KVM: selftests: Add nested transition benchmark
Date: Thu,  5 Nov 2026 02:01:00 +0000
Message-ID: <20261105020104.2507083-19-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Measure L1<->L2 transition costs from L1's viewpoint, in TSC cycles:
a reflected-exit phase (cpuid in L2, forwarded to L1: the full
emulated vmexit->vmentry round trip, exercising the vmcb12/vmcs12
access paths), and on SVM an MSR-intercept phase (rdmsr in L2 with
INTERCEPT_MSR_PROT: exercises the per-intercept lookup in L1's MSR
permissions map). Reports min/avg/p50/p99/max over 10k iterations.

Works on both VMX and SVM.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/nested_transition_bench.c         | 210 ++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_transition_bench.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index dcfe815f4a02..65639e54b554 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -162,6 +162,7 @@ TEST_GEN_PROGS_x86 += x86/recalc_apic_map_test
 TEST_GEN_PROGS_x86 += x86/aperfmperf_test
 TEST_GEN_PROGS_x86 += x86/guest_memfd_conversions_test
 TEST_GEN_PROGS_x86 += x86/vmx_apic_update_test
+TEST_GEN_PROGS_x86 += x86/nested_transition_bench
 TEST_GEN_PROGS_x86 += access_tracking_perf_test
 TEST_GEN_PROGS_x86 += coalesced_io_test
 TEST_GEN_PROGS_x86 += dirty_log_perf_test
diff --git a/tools/testing/selftests/kvm/x86/nested_transition_bench.c b/tools/testing/selftests/kvm/x86/nested_transition_bench.c
new file mode 100644
index 000000000000..ea91ffcc4e0e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_transition_bench.c
@@ -0,0 +1,210 @@
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
+	for (i = 0; i < N_WARMUP; i++) {
+		run_guest(vmcb, svm->vmcb_gpa);
+		GUEST_ASSERT(vmcb->control.exit_code == SVM_EXIT_MSR);
+		vmcb->save.rip += 2; /* rdmsr */
+	}
+
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
+	prepare_for_vmx_operation(vmx);
+	load_vmcs(vmx);
+	prepare_vmcs(vmx, l2_guest_code);
+
+	vmlaunch();
+	/* first exit is here; loop resumes */
+	for (i = 0; i < N_WARMUP; i++) {
+		GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_CPUID);
+		vmwrite(GUEST_RIP, vmread(GUEST_RIP) +
+			vmread(VM_EXIT_INSTRUCTION_LEN));
+		vmresume();
+	}
+
+	for (i = 0; i < N_ITERS; i++) {
+		GUEST_ASSERT(vmread(VM_EXIT_REASON) == EXIT_REASON_CPUID);
+		vmwrite(GUEST_RIP, vmread(GUEST_RIP) +
+			vmread(VM_EXIT_INSTRUCTION_LEN));
+		t0 = rdtsc();
+		vmresume();
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
2.43.0

