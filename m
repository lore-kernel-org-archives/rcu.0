Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844073;
	b=XBqs+kaQEOJ9Dus7moelKRa2pPpj1dVo0d5PR+boNYGjRPXbstSRt+2vBgn8bXguE7uk
	 RbYdukguhqFOYntrTgE7WTphpekSfUdHmlE1APk0Uy51OFPydnFJEQc+u/B2Rfakw1EqT
	 dF/GDZB2EqrnDIyomAAjHN5gxhmFgpn0ry5N7/zTF6nvlAAI9Qf/C3WoEO4A7/95Ya5g9
	 8AzjexV8QsP8wc3AQALZv7GhdseDgXbU0jTwhgBpr9au2Os1gzY9J1tBmD5eRtkBXH+bW
	 4Pumpi9JHn+JlgcCwP7bNUFtN+a1aTewvfE5TLX9bJoYhxrZC8W5yii9UDuHljDpV2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844073;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=pphF2Gry51KkjraDv3DbKbxipU/YNYO4YsKlt2HijlE=;
	b=AvpTNI+NSMReB7CQ46Mq2bOPnHtTeidxkB2gpB1jKgnPUWQgLc2dUB+7wvqUWLeeIsJr
	 c+NaTopr8HBpNEVLrIAWzM4kOV9wrlDbLVvqxW9oVkEAGZFx3HLkj6pvq1PrG4cUyg43/
	 Rdi/EBtQK1S/ec2tqfPB31LUxF7fK/ylwi6AKMlKp71SKnePIse/7YF1WTJKHEo/vejPV
	 psYKYOwBPzXc0KVGU/lggbhE84J77M1AEJCMNYBRVXTrCnOQAgI8Rqm9x93PJRQY8GVhC
	 y8kEjYburZKDTLKyblKnFa1M5+tCg95XFnYSBn4E0ugRv7UuH7wxl/cFAHzSxfUvAww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=W0697dEo;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73C0606EE8A;
	Thu,  5 Nov 2026 02:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B73C0606EE8A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=W0697dEo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=pphF2Gry51KkjraDv3DbKbxipU/YNYO4YsKlt2HijlE=; b=W0697dEoJqJFNkTbdno7tSxg8G
	ryaiNpDrSQQ35mK6NawV27thPKFt0wfyyzkBPAsPnhLMa2+Eupz6srh4Ox0LFNxPCbpsiB78Ac83t
	1LjqqOktxFG7baANhZHISm+eT5QS9ADz5a9+rlEcE8Ijp8Ik664gJ3UZ1NqW2anAl29T2YrA7zHCM
	fWPgveNZhaN9uj8iDSgjwRQU6Dr9381q5jYKSUBPRG5H6k9YqsbkJQI8eFhiF0+h0E5HyzEVCN4eG
	X5RLEagfvhmb07LoZa0QIPu+BlMtf6GxLPaxqMBC+OK70ln83PM0NoheGP6U0PXyG8DcwCGbFs8IY
	fAcvXPWQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037jU-292l;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmn-0000000AWEE-056f;
	Thu, 05 Nov 2026 02:01:05 +0000
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
Subject: [PATCH v2 19/20] KVM: selftests: Add Xen evtchn vs memslot-update race test
Date: Thu,  5 Nov 2026 02:01:01 +0000
Message-ID: <20261105020104.2507083-20-dwmw2@infradead.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Race a guest EVTCHNOP_send loop against a host thread which deletes
and recreates the shared_info memslot. The delivery path runs in the
vCPU's exit-handling context, under vcpu_run's kvm->srcu read
section; if it ever waited there for the memslot update to complete,
it would deadlock against kvm_swap_active_memslots() waiting out that
very read section in synchronize_srcu(), and this test livelocks
within seconds. The deadlock is the one claim the test pins: a send
which races the update legitimately fails (the hypercall bounces to
userspace, which completes it with an error), so the test makes no
assertion about delivery counts beyond "the churn did not starve
delivery entirely".

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/xen_evtchn_memslot_race_test.c    | 232 ++++++++++++++++++
 2 files changed, 233 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 65639e54b554..c17408f8d61f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -149,6 +149,7 @@ TEST_GEN_PROGS_x86 += x86/xss_msr_test
 TEST_GEN_PROGS_x86 += x86/debug_regs
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
+TEST_GEN_PROGS_x86 += x86/xen_evtchn_memslot_race_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
 TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
 TEST_GEN_PROGS_x86 += x86/sev_dbg_test
diff --git a/tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c b/tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c
new file mode 100644
index 000000000000..c9448df52a6e
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * xen_evtchn_memslot_race_test
+ *
+ * A guest EVTCHNOP_send whose delivery races a DELETE/re-CREATE of the
+ * memslot holding the shared_info page. The delivery path runs in the
+ * vCPU's exit-handling context, under vcpu_run's kvm->srcu read
+ * section; if it waits there for the memslot update to complete, it
+ * deadlocks against kvm_swap_active_memslots()'s
+ * synchronize_srcu_expedited() waiting out that very read section.
+ * Regression test for that deadlock: KVM must leave the hypercall
+ * uncompleted so the guest re-executes it, rather than wait in exit
+ * context.
+ *
+ * The guest sends events in a tight loop; a host thread deletes and
+ * recreates the shared_info slot in a tight loop. On a broken host
+ * this livelocks within a second or two (the test then dies by
+ * timeout); on a fixed host the guest completes all N
+ * iterations (sends which hit the no-slot gap between DELETE and
+ * re-CREATE legitimately fail; most deliver).
+ */
+#include <pthread.h>
+#include <stdatomic.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <stdint.h>
+
+#define SHINFO_REGION_GPA	0xc0000000ULL
+#define SHINFO_REGION_SLOT	10
+
+#define EVTCHN_PORT		15
+#define TEST_ITERATIONS		4000
+
+#define EVTCHNOP_send		4
+#define __HYPERVISOR_event_channel_op	32
+
+#define XEN_HYPERCALL_MSR	0x40000000
+
+#define EVTCHNSTAT_ipi		5
+
+struct evtchn_send {
+	uint32_t port;
+};
+
+static void guest_code(void)
+{
+	struct evtchn_send s = { .port = EVTCHN_PORT };
+	int delivered = 0;
+	int i;
+
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		/*
+		 * The delivery may legitimately fail while the shared_info
+		 * slot is mid-churn (between DELETE and re-CREATE there is
+		 * no slot at all, which is -EFAULT, not a transient). The
+		 * failure mode under test is the vCPU never coming back at
+		 * all (deadlock -> timeout), not the hypercall rc.
+		 */
+		if (!__xen_hypercall(__HYPERVISOR_event_channel_op,
+				     EVTCHNOP_send, &s))
+			delivered++;
+		GUEST_SYNC(i);
+	}
+
+	/*
+	 * The churn must not have starved delivery entirely. Every
+	 * iteration exits to userspace for the GUEST_SYNC, so the slot
+	 * spends real wall time present between churn cycles; empirically
+	 * a few hundred of the sends deliver.
+	 */
+	GUEST_ASSERT(delivered);
+
+	/*
+	 * Report the delivered count. The value is always at least
+	 * TEST_ITERATIONS + 1, so the host can distinguish it from the
+	 * in-loop syncs, whose values are below TEST_ITERATIONS.
+	 */
+	GUEST_SYNC(TEST_ITERATIONS + delivered);
+
+	GUEST_DONE();
+}
+
+static atomic_bool churn_stop;
+
+static void *memslot_churn(void *arg)
+{
+	struct kvm_vm *vm = arg;
+
+	while (!atomic_load(&churn_stop)) {
+		vm_mem_region_delete(vm, SHINFO_REGION_SLOT);
+		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+					    SHINFO_REGION_GPA,
+					    SHINFO_REGION_SLOT, 2, 0);
+	}
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	pthread_t thread;
+	struct ucall uc;
+	int bounced = 0;
+	int done = 0;
+
+	int xen_caps = kvm_check_cap(KVM_CAP_XEN_HVM);
+
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO);
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_SEND);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    SHINFO_REGION_GPA, SHINFO_REGION_SLOT, 2, 0);
+
+	struct kvm_xen_hvm_config hvmc = {
+		.flags = KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL |
+			 KVM_XEN_HVM_CONFIG_EVTCHN_SEND,
+		.msr = XEN_HYPERCALL_MSR,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_CONFIG, &hvmc);
+
+	struct kvm_xen_hvm_attr lm = {
+		.type = KVM_XEN_ATTR_TYPE_LONG_MODE,
+		.u.long_mode = 1,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &lm);
+
+	struct kvm_xen_hvm_attr ha = {
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
+		.u.shared_info.gfn = SHINFO_REGION_GPA / PAGE_SIZE,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &ha);
+
+	struct kvm_xen_vcpu_attr vi = {
+		.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO,
+		.u.gpa = SHINFO_REGION_GPA + 0x40,
+	};
+	vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &vi);
+
+	/* Loop the port back to this vCPU as an IPI. */
+	struct kvm_xen_hvm_attr evt = {
+		.type = KVM_XEN_ATTR_TYPE_EVTCHN,
+		.u.evtchn.send_port = EVTCHN_PORT,
+		.u.evtchn.type = EVTCHNSTAT_ipi,
+		.u.evtchn.flags = 0,
+		.u.evtchn.deliver.port.port = EVTCHN_PORT,
+		.u.evtchn.deliver.port.vcpu = vcpu->id,
+		.u.evtchn.deliver.port.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &evt);
+
+	kvm_pthread_create(&thread, NULL, memslot_churn, vm);
+
+	/*
+	 * Self-guard: on a kernel with the deadlock under test, the vCPU
+	 * never returns from KVM_RUN. Die with SIGALRM rather than hang
+	 * when run standalone. Deliberately no SIGALRM handler: in the
+	 * deadlock, no thread ever returns to userspace to run one, and a
+	 * handled signal is no longer fatal, so only the default
+	 * disposition can kill the process (exit by SIGALRM is the
+	 * failure signature). One budget for the whole run — a healthy
+	 * kernel finishes in seconds, and a per-iteration bound would
+	 * impose a KVM_RUN latency claim this test doesn't make.
+	 * (On a CONFIG_DEBUG_LOCK_ALLOC kernel which has regressed, the
+	 * wait degrades to a transient failure instead of deadlocking,
+	 * and this test cannot see that; the WARN it fires can.)
+	 */
+	alarm(90);
+
+	while (!done) {
+		vcpu_run(vcpu);
+
+		/*
+		 * In the window where the shared_info slot is fully deleted
+		 * (between the churn thread's DELETE and re-CREATE), the
+		 * delivery fails with -EFAULT and the hypercall bounces to
+		 * userspace as KVM_EXIT_XEN. Complete it with an error
+		 * result and keep going; the failure mode under test is
+		 * the vCPU never coming back (deadlock -> timeout), not
+		 * the hypercall rc.
+		 */
+		if (vcpu->run->exit_reason == KVM_EXIT_XEN &&
+		    vcpu->run->xen.type == KVM_EXIT_XEN_HCALL) {
+			TEST_ASSERT(vcpu->run->xen.u.hcall.input ==
+					__HYPERVISOR_event_channel_op &&
+				    vcpu->run->xen.u.hcall.params[0] ==
+					EVTCHNOP_send,
+				    "Unexpected hypercall bounce: input %llu params[0] %llu",
+				    vcpu->run->xen.u.hcall.input,
+				    vcpu->run->xen.u.hcall.params[0]);
+			vcpu->run->xen.u.hcall.result = -EFAULT;
+			bounced++;
+			continue;
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			/*
+			 * The final sync reports how many of the sends were
+			 * delivered: purely a diagnostic for how much of the
+			 * churn the guest actually raced with.
+			 */
+			if (uc.args[1] >= TEST_ITERATIONS)
+				pr_info("%lu of %u sends delivered, %d bounced\n",
+					uc.args[1] - TEST_ITERATIONS,
+					TEST_ITERATIONS, bounced);
+			break;
+		case UCALL_DONE:
+			done = 1;
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		default:
+			TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+		}
+	}
+
+	atomic_store(&churn_stop, true);
+	kvm_pthread_join(thread, NULL);
+	alarm(0);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.43.0

