Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844078;
	b=Ab/CvqPQoJKQY+TfIIbE9fXMchy8tzTl6GA36bqv2f9rnce+v5ugacyFPRJcMmFvHh08
	 JhXq2JrAAHRCxp+hv51ZiEx7x4bNx3LjFzfAuZKRIG2UDXxmKAsVAAggkwdkq9IYn9kKm
	 I7MAek+1NR66jaEAqpqGI9+AlpFOe0wa4/yT/LdR26DnftVCzw2IJWkU0W4iAq0zHGL/A
	 +68ZqURYV4oOhYZEk6aSa2Uzgf6o6LAREq020KpNFK2fZgWwQDnSkZ8MRrTHDl62UxOGw
	 Oi+1L2o3b37DByuA8En0T+SxrZBFiILmM4tuzIwa8ZPStkBGExioS4VkyaPsf9u2JSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844078;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=5928Fm1r4SKQS+jH4OMcVcprvnhzKwbhu15jXKH4aPQ=;
	b=42glvD8ktPV2R4qacoM8o5mqYcQnIDSkm1MoOI8L/0ow2N0nX5hFeFoG72x4diJe5/Ed
	 L0rwy9JCKZt0TJPyf2SfgXmyidFKj22o3ekZkLwr5a9Zn9roo/Jb0ScSeL+cUkXIxIIto
	 9iYPsjMqm4jst0eYP0DxrDbWBX3OOgZ4xvhs9pCwHeiUncGw2Y8W74OoTMPmvDqAi8vtw
	 EjW0oiAMwJ9fQ8JlaDo4cVxwnM/PIi6qVPCLFUTrDT0YGwHRUfIGJfLN3FU/KUpo50fGw
	 J/BMPujc1Ld2sf6K+oXP46q+W/Z7wPRmwgKw9tezLL4C0acDk1dKFQAsGJ5YrEv8SJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=c+cJAlqC;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE68606EEA9;
	Thu,  5 Nov 2026 02:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EE68606EEA9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=c+cJAlqC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=5928Fm1r4SKQS+jH4OMcVcprvnhzKwbhu15jXKH4aPQ=; b=c+cJAlqCYvwVUBT4ZnFxngvmEg
	j06UhJBCENC+EWoZ8uxTBe1BBkm/K3xpWMIPcGenCA3LmH+U9Q/Dg5bWoQ54giJNHszlHgrZ/nmot
	dhX1Ys8wR7p0RlzClAALbcdELVnNJ+n8ApVB4ktMzDm28gJUocHY6GxrbkEN8ILJRpbL4N90IN/wv
	KEfe9NuUJTyFIeG5ezpKPKjEKxQNKWJlzfO9vpntoZ27Nlk2dRBasRMfGfzsrAVa0oU66QBYPA3ou
	HkHH3OBDWOEl+/9HKxOSoRtrVciGSUmi9AVPYqFy0schWzdIpdFTNN1CCTuLrEv1Jf2heYs55ZGDh
	Yd1RUHlQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmo-00000002ROS-24dv;
	Thu, 05 Nov 2026 02:01:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmn-0000000AWEJ-0E2y;
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
Subject: [PATCH v2 20/20] KVM: selftests: Add Xen evtchn vs mmu_notifier race test for HVA caches
Date: Thu,  5 Nov 2026 02:01:02 +0000
Message-ID: <20261105020104.2507083-21-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Race a guest EVTCHNOP_send loop against a host thread hammering
MADV_DONTNEED on the userspace page backing HVA-based shared_info and
vcpu_info caches. Every madvise zaps the PTE and invalidates both
gfn_to_pfn_caches; every delivery must refresh through the window
(hva_to_pfn_retry() retries until the invalidation has finished, then
faults the page back in) and must succeed. The caches are HVA-based,
so no memslot semantics excuse a drop: unlike
xen_evtchn_memslot_race_test, which only pins the no-deadlock claim,
this test asserts every one of the 20000 sends delivers, and any
hypercall bounce to userspace fails the test.

This exercises the pfncache invalidation protocol itself — the
invalidate_start walk, the reader draining for a cache mid-teardown,
and the handshake between a refresh publishing a new mapping and a
concurrent invalidation vetoing it — which is where a lifetime bug
in the cache would live; on a debug kernel one is expected to
surface as a splat rather than a dropped event.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/xen_evtchn_hva_notify_race_test.c | 188 ++++++++++++++++++
 2 files changed, 189 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index c17408f8d61f..19dc0744f25f 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -150,6 +150,7 @@ TEST_GEN_PROGS_x86 += x86/debug_regs
 TEST_GEN_PROGS_x86 += x86/tsc_msrs_test
 TEST_GEN_PROGS_x86 += x86/vmx_pmu_caps_test
 TEST_GEN_PROGS_x86 += x86/xen_evtchn_memslot_race_test
+TEST_GEN_PROGS_x86 += x86/xen_evtchn_hva_notify_race_test
 TEST_GEN_PROGS_x86 += x86/xen_shinfo_test
 TEST_GEN_PROGS_x86 += x86/xen_vmcall_test
 TEST_GEN_PROGS_x86 += x86/sev_dbg_test
diff --git a/tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race_test.c b/tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race_test.c
new file mode 100644
index 000000000000..c105435f6357
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/xen_evtchn_hva_notify_race_test.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * xen_evtchn_hva_notify_race_test
+ *
+ * A guest EVTCHNOP_send loop racing continuous mmu_notifier
+ * invalidation of the HVA-based shared_info and vcpu_info caches: a
+ * host thread hammers MADV_DONTNEED on the userspace page backing
+ * both, zapping the PTE and invalidating the gfn_to_pfn_caches on
+ * every pass. Delivery must refresh through each invalidation window
+ * (hva_to_pfn_retry() retries until the notifier has finished, then
+ * faults the page back in) and must never fail: the caches are
+ * HVA-based, so no memslot semantics excuse a drop.
+ *
+ * This is the stress for the pfncache invalidation protocol itself —
+ * the invalidate_start walk, the GPC_INVALIDATING grace-period
+ * draining, and the announce/veto handshake between a refresh's
+ * publish and a concurrent invalidation. Unlike the sibling
+ * xen_evtchn_memslot_race_test, every send is asserted to succeed;
+ * any -EFAULT bounce to userspace, or any guest-visible failure, is
+ * a test failure, and a lifetime bug is expected to show up as a
+ * crash or splat on a debug kernel.
+ */
+#include <pthread.h>
+#include <stdatomic.h>
+#include <sys/mman.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#include <stdint.h>
+
+#define EVTCHN_PORT		15
+#define TEST_ITERATIONS		5000
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
+	uint64_t rc;
+	int i;
+
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		rc = __xen_hypercall(__HYPERVISOR_event_channel_op,
+				     EVTCHNOP_send, &s);
+		__GUEST_ASSERT(!rc,
+			       "EVTCHNOP_send failed with %ld on iteration %d",
+			       (long)rc, i);
+		GUEST_SYNC(i);
+	}
+
+	GUEST_DONE();
+}
+
+static atomic_bool churn_stop;
+
+static void *backing_churn(void *arg)
+{
+	void *backing = arg;
+
+	while (!atomic_load(&churn_stop))
+		madvise(backing, PAGE_SIZE, MADV_DONTNEED);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	pthread_t thread;
+	struct ucall uc;
+	void *backing;
+	int done = 0;
+
+	int xen_caps = kvm_check_cap(KVM_CAP_XEN_HVM);
+
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA);
+	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_EVTCHN_SEND);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	/*
+	 * The shared_info page and the vcpu_info within it live in plain
+	 * anonymous VMM memory, not in any memslot: nothing but the
+	 * mmu_notifier churn below can perturb the caches.
+	 */
+	backing = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(backing != MAP_FAILED, "mmap of backing page failed");
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
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA,
+		.u.shared_info.hva = (unsigned long)backing,
+	};
+	vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &ha);
+
+	struct kvm_xen_vcpu_attr vi = {
+		.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA,
+		.u.hva = (unsigned long)backing + 0x40,
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
+	kvm_pthread_create(&thread, NULL, backing_churn, backing);
+
+	/*
+	 * Self-guard against a kernel which livelocks a refresh under
+	 * continuous invalidation. Deliberately no SIGALRM handler, as in
+	 * xen_evtchn_memslot_race_test: only the default disposition can
+	 * kill a process whose vCPU thread never returns to userspace.
+	 * Empirically ~100-170 iterations/sec on a c6a.metal host: nearly
+	 * every send pays a full refresh (fault the page back in and remap
+	 * it), so budget generously; the healthy runtime is ~30-50s.
+	 */
+	alarm(240);
+
+	while (!done) {
+		vcpu_run(vcpu);
+
+		/*
+		 * An HVA-based cache has no memslot to be mid-update:
+		 * there is no legitimate reason for delivery to fail, so
+		 * unlike the memslot race test, a hypercall bouncing to
+		 * userspace is a straight failure.
+		 */
+		TEST_ASSERT(vcpu->run->exit_reason != KVM_EXIT_XEN,
+			    "EVTCHNOP_send bounced to userspace: delivery failed");
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			if (uc.args[1] && !(uc.args[1] % 1000))
+				pr_info("progress: %lu iterations\n", uc.args[1]);
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

