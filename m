Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844071;
	b=UFNWXQLcAg+x291Riv7cIRnnj3ZWaoWSYwLedA3Q9h1oG6Zbg7HZFl7KtACvREjHRcp8
	 YaevPrRa4rpBNdT6VcKbnFmccI0Uxx65g5ohqvsPgG40mWtyOXVB1TikEgE69G4wrTSTD
	 rHJbXdCwgvLCR5dpk4l3mLlX0C6fAjHiNbBD8cHS2JoU4AT+QY1xlo249vgVf4ceWfJF2
	 hXnToAayukj6PLwDnL+vBZ65QWU//9aBQFi1rTwi115Ea6g/kSKuHVLeh2VHdoDj0BvTs
	 dJutxYtGwkfzk07bq9m0gxSJ1iRnrfRJrnPsBpMbYfH8KFnIMsdHMWzjMGptH40hYqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844071;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=EjC93C9IT1HB5U8uFJ3DkGgCAi5EPZ8cZ/bI0C1PcNQ=;
	b=q+k2Z3VgsrBtW0vec+jeU/QOam1fgtA27RH8aNxSdXztX2EJkItz2dQaVLwuJg/I52g4
	 PoyKXEoNlrmlW5MHi+Cj1fEl0kWSNbFT5S1FeRkvMUnaPnvfMFgeaCGssZdQtkqzOxi8j
	 6Aprhi2/71dkPUFYg6wbZ71cQDCXWaCL5a7l2SSLsiUgX20e73NZFtYvI/DCsulZug75o
	 zCVTXfga3xX4bLBuPr7vSkJvsWMxcJR75LLIsNBNpqZiasJ1WIsiD74RT/Ai3xCTibeXV
	 +iJVTZXQXtmEivgbgOSJKwigrDwR/MCRO8t+/nUTdkCTAi5JMfPaLDhrbRNqih1u4RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KZEVV+Cu;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE3606A335;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAAE3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KZEVV+Cu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EjC93C9IT1HB5U8uFJ3DkGgCAi5EPZ8cZ/bI0C1PcNQ=; b=KZEVV+Cusbxv+cqJ1kbyuEa7Xp
	Az5YvzTCVTn9BkjUQ7VoLal2X0iJkw80mTjX0LIKlBJtOMc6AFj5zUxXoY3upW8Y44SaabIXm0NT0
	gMFVL5VU6OwVFfCc8BjLvtJ8NedNhW/ullEBc3evR79R3CpbEijH9bn0OUb0na0yElKw3Mf3upGBk
	HT6tNjFHToAEN7pEX52g2+Akf+UGqrtNXYXd3Mz2aAdy0hmTBOshjxqKlq6/TkHb8vwl+/Z/IIcAA
	aVfCQ2V9x73SR9sYDQ79umK5i4H/e4pCwDw5/TkyFevg+8n+okm/x/oFvt3MXcC2HPXn0K1I4Ik57
	rhdArMew==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037j8-0FsG;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDD-150I;
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
Subject: [PATCH v2 04/20] KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
Date: Thu,  5 Nov 2026 02:00:46 +0000
Message-ID: <20261105020104.2507083-5-dwmw2@infradead.org>
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

From: Sean Christopherson <seanjc@google.com>

Explicitly mark the Xen shared info page as never being dirty tracked so
that higher-level gpc APIs can be added to automatically take care of
things like dirty tracking, without reintroducing the bug fixed by
commit 55749769fe60 ("KVM: x86: Fix wall clock writes in Xen shared_info
not to mark page dirty").  And because the code _looks_ buggy.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c        |  2 +-
 include/linux/kvm_host.h  | 15 +++++++++++----
 include/linux/kvm_types.h |  1 +
 virt/kvm/pfncache.c       |  4 +++-
 4 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 4517eeb24909..d3773416cd44 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2485,7 +2485,7 @@ void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
 	xa_init(&kvm->arch.xen.evtchn_ports);
-	kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm);
+	__kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm, true);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e7fc94e2910a..cadd0318400e 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1459,16 +1459,23 @@ int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 			 unsigned long len);
 
 /**
- * kvm_gpc_init - initialize gfn_to_pfn_cache.
+ * __kvm_gpc_init - initialize gfn_to_pfn_cache.
  *
  * @gpc:	   struct gfn_to_pfn_cache object.
  * @kvm:	   pointer to kvm instance.
+ * @never_dirty:   the cache never needs to mark its page dirty in its memslot.
  *
  * This sets up a gfn_to_pfn_cache by initializing locks and assigning the
  * immutable attributes.  Note, the cache must be zero-allocated (or zeroed by
- * the caller before init).
+ * the caller before init).  Most callers want the kvm_gpc_init() wrapper.
  */
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm);
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    bool never_dirty);
+
+static inline void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+{
+	__kvm_gpc_init(gpc, kvm, false);
+}
 
 /**
  * kvm_gpc_activate - prepare a cached kernel mapping and HPA for a given guest
@@ -1979,7 +1986,7 @@ static inline void kvm_gpc_mark_dirty_in_slot(struct gfn_to_pfn_cache *gpc)
 {
 	lockdep_assert_held(&gpc->lock);
 
-	if (!gpc->memslot)
+	if (!gpc->memslot || gpc->never_dirty)
 		return;
 
 	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpa_to_gfn(gpc->gpa));
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index a568d8e6f4e8..e850adc3f47e 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -94,6 +94,7 @@ struct gfn_to_pfn_cache {
 	kvm_pfn_t pfn;
 	bool active;
 	bool valid;
+	bool never_dirty;
 };
 
 #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 3659686b97c2..17a30da00d40 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -382,7 +382,8 @@ int kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, unsigned long len)
 	return __kvm_gpc_refresh(gpc, gpc->gpa, uhva);
 }
 
-void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
+void __kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm,
+		    bool never_dirty)
 {
 	rwlock_init(&gpc->lock);
 	mutex_init(&gpc->refresh_lock);
@@ -392,6 +393,7 @@ void kvm_gpc_init(struct gfn_to_pfn_cache *gpc, struct kvm *kvm)
 	gpc->gpa = INVALID_GPA;
 	gpc->uhva = KVM_HVA_ERR_BAD;
 	gpc->active = gpc->valid = false;
+	gpc->never_dirty = never_dirty;
 }
 
 static int __kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long uhva,
-- 
2.43.0

