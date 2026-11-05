Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844079;
	b=mhOb4NHx4iABPO5FegwziGEYQPjbpPaiMbg9KqOdVbJVjTy+dzWgsErLXTcQrSEhvkcT
	 BOEf5FLp9wIuTTKX9DOYMcaky3lXvvi/ONP7DODndKbCRc9oZ+2jEs8wIcIVNydhEB1Tl
	 qXhb0ptHAZyb/mssUbF2gkvMGrF83+RB1qww8mZCHlgtWI47n70Zs5oDlKnwB2r1oRp9M
	 j3SrxCJ57sqgI5aZ7ROeeAT+IDjkp9yvIFTH/KVTLSejxgESVFcTtKnrKup9y0bBJ+E9a
	 FW4lurIwy4IWrQybTVkJUUZS26md/17+Z3ICrYYU8ONUmjwH8kyAQFt4uH5aBTaUwAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844079;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=ihM6W4dC3NBcXSxQRanAZyoU5ddBab3XKFn/HuD51Wc=;
	b=jp14PpYFU5BUhB1rvgL3WvZoYDe2yzZU1/ZA8rVabUMuB+EKefEZLQh5sGhow3Y1agIE
	 zfaM+GpJm6oqbSpGj2r5MQP0LGwpdBpjAigLZ+yd3cxs4+M7Nao5m4vdbst1LGaXnqWyH
	 iHZd5KgVx/lvixGSHn6HdpbTHLrSeK8E6l4V7cBb2MkHHURWdCOJiW6P8GckqQmE+1i7r
	 BpFm+Rw7JyCXM7l/rbi1Xs237wXRkYLEXYEqZl28FMyIRoI7MPpf7Ti7LZC4xNmrZCLXf
	 +ecR+B2mrPbNbQwY2Jjre1DBw/kkuVFZ0boeAaIZbjxZRULwpGpHutqUDp24Xp6siXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=GQmbxoGn;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D5606EE99;
	Thu,  5 Nov 2026 02:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F8D5606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=GQmbxoGn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=ihM6W4dC3NBcXSxQRanAZyoU5ddBab3XKFn/HuD51Wc=; b=GQmbxoGnz87qdbqTY6OXzQHbYj
	I4kFK9Kdgbo09j349zxtFiYaP6kwlwpp6ZqTcIOhbhPwIoBcG/X5Ghe0ngQNSbFSynEktxRg1ebzz
	FbTbmXwtuyt2pshjrp6YUqClUSde9rqEHfogjfaRdzy3xWe5vkVpOqfFMdianJnxsBLJIIb6b7zhu
	LIZmPR7ZN9YNdhXMw/KTqxO34uCvBoFhQsooHC0rtz5s7Xw6FN2Z4AhOd2OB7OYqPWVZg45oir7Fd
	oLJJ/8hLKJbcTLKb+PiHCYP8cRhBGZVOXWS14ZJD0avSmM5NKG7soPeLGMmwBKhO7Q7jAQeTBIhcI
	7O8PPKFQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-00000002ROM-26z6;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWD7-0ouU;
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
Subject: [PATCH v2 02/20] KVM: x86/xen: Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
Date: Thu,  5 Nov 2026 02:00:44 +0000
Message-ID: <20261105020104.2507083-3-dwmw2@infradead.org>
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

Commit 3617c0ee7dec ("KVM: x86/xen: Only write Xen hypercall page for
guest writes to MSR") blocked host-initiated writes from triggering the
Xen hypercall page setup, to fix an SRCU usage violation when the
hypercall MSR index collides with a real MSR written during vCPU reset.

However, some VMMs legitimately need to trigger hypercall page setup
from host context. For example, a VMM may intercept the guest's MSR
write to track an epoch (for kexec/crash recovery), and then replay the
write as a host-initiated KVM_SET_MSRS to populate the hypercall page.
The host_initiated check breaks this use case.

Add KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE as a vCPU attribute
which invokes the write explicitly. The work moves into a helper
called with xen_lock held — which the attribute handler already holds,
and which now covers the whole operation, serializing the writes to
guest memory — in the shape the original posting's review asked for:
handled in the attribute case-statement, with no locking games of its
own. The helper returns raw errnos for each caller to map onto its own
contract: the attribute returns them to userspace as they are, while
the guest WRMSR raises #GP for anything but -ENOMEM. That includes a
fault reading the VMM-supplied blob, which previously escaped to
userspace as -EFAULT: by that point it is indistinguishable from the
guest's own bad page_addr, and #GP serves them both. The helper also
reverts the latched long_mode when the shared_info re-init fails —
on both entry points, including the guest WRMSR path — where the old
code left it latched, letting a retry of the same write skip the
re-init and "succeed" with the wallclock still published at the
offset for the old bitness.

The Fixes: tag documents which commit regressed the use case; since
this patch adds new UAPI (an attribute and a capability bit), it is
not suitable for backporting to stable kernels.

Fixes: 3617c0ee7dec ("KVM: x86/xen: Only write Xen hypercall page for guest writes to MSR")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst                |  22 +++-
 arch/x86/include/uapi/asm/kvm.h               |   3 +
 arch/x86/kvm/x86.c                            |   3 +-
 arch/x86/kvm/xen.c                            |  73 ++++++++---
 .../selftests/kvm/x86/xen_vmcall_test.c       | 118 ++++++++++++++++++
 5 files changed, 203 insertions(+), 16 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d..70818f1353c3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5848,6 +5848,23 @@ KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR
   vector configured with HVM_PARAM_CALLBACK_IRQ. It is disabled by
   setting the vector to zero.
 
+KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE
+  This attribute is available when the KVM_CAP_XEN_HVM ioctl indicates
+  support for KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE. It populates the
+  Xen hypercall page at the guest physical address given in ``gpa``,
+  just as a guest write to the hypercall MSR would. This is for VMMs
+  which intercept the guest's MSR write (e.g. to track an epoch for
+  kexec/crash recovery) and then need to perform the write themselves:
+  host-initiated writes through KVM_SET_MSRS do not populate the page.
+  As for the guest's own write, the vCPU's current long mode is latched
+  as the VM-wide Xen long_mode, and the shared_info wallclock is
+  re-published if that changed. The value is interpreted exactly as the
+  guest's MSR write would be, not as a plain address: when Xen hypercall
+  interception is enabled, any non-zero bits below the page size make
+  the write fail with -EINVAL; without interception, those bits select
+  which page of the VMM-provided hypercall blob is written, and a page
+  number beyond the blob fails with -EINVAL.
+
 
 4.129 KVM_XEN_VCPU_GET_ATTR
 ---------------------------
@@ -5861,7 +5878,8 @@ KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR
 Allows Xen vCPU attributes to be read. For the structure and types,
 see KVM_XEN_VCPU_SET_ATTR above.
 
-The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
+The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST and
+KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE types may not be used
 with the KVM_XEN_VCPU_GET_ATTR ioctl.
 
 4.130 KVM_ARM_MTE_COPY_TAGS
@@ -9509,6 +9527,8 @@ PVHVM guests. Valid flags are::
   #define KVM_XEN_HVM_CONFIG_EVTCHN_SEND		(1 << 5)
   #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
   #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
+  #define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA		(1 << 8)
+  #define KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE	(1 << 9)
 
 The KVM_XEN_HVM_CONFIG_HYPERCALL_MSR flag indicates that the KVM_XEN_HVM_CONFIG
 ioctl is available, for the guest to set its hypercall page.
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 00ce265391e1..e53a26370e50 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -596,6 +596,7 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG	(1 << 6)
 #define KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE	(1 << 7)
 #define KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA	(1 << 8)
+#define KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE	(1 << 9)
 
 #define KVM_XEN_MSR_MIN_INDEX			0x40000000u
 #define KVM_XEN_MSR_MAX_INDEX			0x4fffffffu
@@ -704,6 +705,8 @@ struct kvm_xen_vcpu_attr {
 #define KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR	0x8
 /* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA */
 #define KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA	0x9
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE */
+#define KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE	0xa
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 32563a91fba9..6a1f0404f029 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2315,7 +2315,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		    KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL |
 		    KVM_XEN_HVM_CONFIG_EVTCHN_SEND |
 		    KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE |
-		    KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA;
+		    KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA |
+		    KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE;
 		if (sched_info_on())
 			r |= KVM_XEN_HVM_CONFIG_RUNSTATE |
 			     KVM_XEN_HVM_CONFIG_RUNSTATE_UPDATE_FLAG;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 5875d10ae3a9..2718da1320e0 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -33,6 +33,7 @@
 static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm);
 static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr *data);
 static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
+static int __kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data);
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
@@ -1177,6 +1178,15 @@ int kvm_xen_vcpu_set_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		}
 		break;
 
+	case KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE:
+		/* KVM cannot read a protected guest's bitness to latch it. */
+		if (vcpu->arch.guest_state_protected) {
+			r = -EINVAL;
+			break;
+		}
+		r = __kvm_xen_write_hypercall_page(vcpu, data->u.gpa);
+		break;
+
 	default:
 		break;
 	}
@@ -1312,30 +1322,42 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 	return r;
 }
 
-int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
+/*
+ * Latch the guest's bitness, re-publish the wallclock in the right
+ * place for it if needed, and fill the hypercall page. Called with
+ * xen_lock held, which serializes the writes to guest memory, and
+ * within a kvm->srcu read section.
+ *
+ * Returns raw errnos for each caller to map onto its own contract:
+ * -EINVAL for an out-of-range page_num; -EFAULT for a fault writing
+ * the page, whether through the guest's page_addr or from the VMM's
+ * blob address; -ENOMEM from the page allocations.
+ */
+static int __kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 {
 	struct kvm *kvm = vcpu->kvm;
 	u32 page_num = data & ~PAGE_MASK;
 	u64 page_addr = data & PAGE_MASK;
 	bool lm = is_long_mode(vcpu);
-	int r = 0;
 
-	mutex_lock(&kvm->arch.xen.xen_lock);
+	lockdep_assert_held(&kvm->arch.xen.xen_lock);
+
 	if (kvm->arch.xen.long_mode != lm) {
 		kvm->arch.xen.long_mode = lm;
 
 		/*
 		 * Re-initialize shared_info to put the wallclock in the
-		 * correct place.
+		 * correct place. On failure, revert the latched long_mode:
+		 * leaving it latched would make a retry of the same write
+		 * skip this block and "succeed" with the wallclock still
+		 * published at the offset for the old bitness.
 		 */
 		if (kvm->arch.xen.shinfo_cache.active &&
-		    kvm_xen_shared_info_init(kvm))
-			r = 1;
+		    kvm_xen_shared_info_init(kvm)) {
+			kvm->arch.xen.long_mode = !lm;
+			return -EFAULT;
+		}
 	}
-	mutex_unlock(&kvm->arch.xen.xen_lock);
-
-	if (r)
-		return r;
 
 	/*
 	 * If Xen hypercall intercept is enabled, fill the hypercall
@@ -1349,7 +1371,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		int ret, i;
 
 		if (page_num)
-			return 1;
+			return -EINVAL;
 
 		/* mov imm32, %eax */
 		instructions[0] = 0xb8;
@@ -1376,7 +1398,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		ret = kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE);
 		kfree(page);
 		if (ret)
-			return 1;
+			return ret;
 	} else {
 		/*
 		 * Note, truncation is a non-issue as 'lm' is guaranteed to be
@@ -1390,7 +1412,7 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		int ret;
 
 		if (page_num >= blob_size)
-			return 1;
+			return -EINVAL;
 
 		blob_addr += page_num * PAGE_SIZE;
 
@@ -1401,11 +1423,34 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		ret = kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE);
 		kfree(page);
 		if (ret)
-			return 1;
+			return ret;
 	}
 	return 0;
 }
 
+/* The guest WRMSR entry point. */
+int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
+{
+	struct kvm *kvm = vcpu->kvm;
+	int r;
+
+	mutex_lock(&kvm->arch.xen.xen_lock);
+	r = __kvm_xen_write_hypercall_page(vcpu, data);
+	mutex_unlock(&kvm->arch.xen.xen_lock);
+
+	/*
+	 * Any failure to populate the page raises #GP; only -ENOMEM is
+	 * signalled upwards. The one deliberate change: a fault reading
+	 * the VMM-supplied blob previously escaped to userspace as
+	 * -EFAULT, but by this point it is indistinguishable from the
+	 * guest's own bad page_addr, and #GP serves them both.
+	 */
+	if (r && r != -ENOMEM)
+		return 1;
+
+	return r;
+}
+
 int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
 {
 	/* Only some feature flags need to be *enabled* by userspace */
diff --git a/tools/testing/selftests/kvm/x86/xen_vmcall_test.c b/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
index 2585087cdf5c..85d836ddbdb8 100644
--- a/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_vmcall_test.c
@@ -12,6 +12,8 @@
 #include "processor.h"
 #include "hyperv.h"
 
+#include <string.h>
+
 #define HCALL_REGION_GPA	0xc0000000ULL
 #define HCALL_REGION_SLOT	10
 
@@ -26,6 +28,10 @@
 #define HVCALL_SIGNAL_EVENT		0x005d
 #define HV_STATUS_INVALID_ALIGNMENT	4
 
+enum {
+	TEST_WRITE_HYPERCALL_PAGE = 1,
+};
+
 static void guest_code(void)
 {
 	unsigned long rax = INPUTVALUE;
@@ -76,18 +82,74 @@ static void guest_code(void)
 			     "r"(r8));
 	GUEST_ASSERT(rax == HV_STATUS_INVALID_ALIGNMENT);
 
+	/*
+	 * Test KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE: ask userspace
+	 * to set up MSR filtering, then write the MSR. The WRMSR will exit
+	 * to userspace (not populate the page). Userspace verifies the page
+	 * is empty, uses the attr to populate it, then resumes us.
+	 */
+	GUEST_SYNC(TEST_WRITE_HYPERCALL_PAGE);
+
+	__asm__ __volatile__("wrmsr" : : "c" (XEN_HYPERCALL_MSR),
+			     "a" (HCALL_REGION_GPA & 0xffffffff),
+			     "d" (HCALL_REGION_GPA >> 32));
+
+	/* Userspace populated the page via the attr — verify it works */
+	rax = INPUTVALUE;
+	rdi = ARGVALUE(1);
+	rsi = ARGVALUE(2);
+	rdx = ARGVALUE(3);
+	r10 = ARGVALUE(4);
+	r8 = ARGVALUE(5);
+	r9 = ARGVALUE(6);
+	__asm__ __volatile__("call *%1" : "=a"(rax) :
+			     "r"(HCALL_REGION_GPA + INPUTVALUE * 32),
+			     "a"(rax), "D"(rdi), "S"(rsi), "d"(rdx),
+			     "r"(r10), "r"(r8), "r"(r9));
+	GUEST_ASSERT(rax == RETVALUE);
+
 	GUEST_DONE();
 }
 
+static void setup_msr_filter(struct kvm_vm *vm)
+{
+	uint64_t deny_bits = 0;
+	struct kvm_msr_filter filter = {
+		.flags = KVM_MSR_FILTER_DEFAULT_ALLOW,
+		.ranges = {
+			{
+				.flags = KVM_MSR_FILTER_WRITE,
+				.nmsrs = 1,
+				.base = XEN_HYPERCALL_MSR,
+				.bitmap = (uint8_t *)&deny_bits,
+			},
+		},
+	};
+
+	vm_ioctl(vm, KVM_X86_SET_MSR_FILTER, &filter);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned int xen_caps;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
+	bool msr_filter_ready = false;
+	bool attr_tested = false;
 
 	xen_caps = kvm_check_cap(KVM_CAP_XEN_HVM);
 	TEST_REQUIRE(xen_caps & KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL);
 
+	/*
+	 * Without these, skip only the WRITE_HYPERCALL_PAGE leg: the MSR
+	 * filter is never installed, so the guest's second WRMSR fills
+	 * the page through KVM as the first did, and the rest of the
+	 * test still runs on older kernels.
+	 */
+	bool have_whp = (xen_caps & KVM_XEN_HVM_CONFIG_WRITE_HYPERCALL_PAGE) &&
+			kvm_check_cap(KVM_CAP_X86_USER_SPACE_MSR) &&
+			kvm_check_cap(KVM_CAP_X86_MSR_FILTER);
+
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	vcpu_set_hv_cpuid(vcpu);
 
@@ -123,6 +185,42 @@ int main(int argc, char *argv[])
 			continue;
 		}
 
+		if (run->exit_reason == KVM_EXIT_X86_WRMSR) {
+			/* MSR filter caught the Xen hypercall MSR write */
+			TEST_ASSERT(msr_filter_ready,
+				    "Unexpected WRMSR exit before filter setup");
+			TEST_ASSERT_EQ(run->msr.index, XEN_HYPERCALL_MSR);
+
+			/*
+			 * The MSR filter should have prevented KVM from
+			 * populating the page. Verify it's empty.
+			 */
+			uint8_t *hcall_page = addr_gpa2hva(vm, HCALL_REGION_GPA);
+
+			TEST_ASSERT_EQ(hcall_page[0], 0);
+
+			/*
+			 * Now use the attr to populate the page, as a
+			 * VMM would after intercepting the MSR write.
+			 */
+			struct kvm_xen_vcpu_attr attr = {
+				.type = KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE,
+				.u.gpa = HCALL_REGION_GPA,
+			};
+			vcpu_ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &attr);
+
+			/* Verify the page is now populated */
+			TEST_ASSERT_EQ(hcall_page[0], 0xb8);
+			TEST_ASSERT_EQ(*(uint32_t *)&hcall_page[1], 0);
+			TEST_ASSERT_EQ(hcall_page[INPUTVALUE * 32], 0xb8);
+			TEST_ASSERT_EQ(*(uint32_t *)&hcall_page[INPUTVALUE * 32 + 1],
+				       INPUTVALUE);
+			attr_tested = true;
+
+			run->msr.error = 0;
+			continue;
+		}
+
 		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
 		switch (get_ucall(vcpu, &uc)) {
@@ -130,6 +228,21 @@ int main(int argc, char *argv[])
 			REPORT_GUEST_ASSERT(uc);
 			/* NOT REACHED */
 		case UCALL_SYNC:
+			TEST_ASSERT_EQ(uc.args[1], TEST_WRITE_HYPERCALL_PAGE);
+
+			if (!have_whp)
+				break;
+
+			/*
+			 * Guest is about to write the Xen MSR. Clear the
+			 * hypercall page, install an MSR filter to intercept
+			 * the write, and enable userspace MSR exits.
+			 */
+			memset(addr_gpa2hva(vm, HCALL_REGION_GPA), 0, PAGE_SIZE);
+			vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR,
+				      KVM_MSR_EXIT_REASON_FILTER);
+			setup_msr_filter(vm);
+			msr_filter_ready = true;
 			break;
 		case UCALL_DONE:
 			goto done;
@@ -138,6 +251,11 @@ int main(int argc, char *argv[])
 		}
 	}
 done:
+	if (have_whp)
+		TEST_ASSERT(attr_tested,
+			    "WRITE_HYPERCALL_PAGE attr was never exercised");
+	else
+		pr_info("Skipped KVM_XEN_VCPU_ATTR_TYPE_WRITE_HYPERCALL_PAGE\n");
 	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.43.0

