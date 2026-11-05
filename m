Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844072;
	b=pkvjtUBHzuAKm9eA+0tLb6dJr+cp/oYWz6moJhY7QfHZA5u4x0F3uh46Y1ZJnYh1kqH4
	 XDXVskJR5/10gSxuUI0idEMMqpZNjXcLoXu2VbDjDmsm9uAc6o9jWjKMMm6yrSnBuwyQm
	 D7F8s4qaCPqMDpok93i6N/kreTPT3ZNCFk+4n405I3IYTPG4BJhHWsl4faYPLrBO+DPjW
	 a8lPgkcc3PtXZ4kwizoF6GGra/TzA/UtqjYxWk0nX6tGa5ZJcc9nvjeMydamY932uN/8Q
	 UOynvJ6wEEXqjAxNrznG3+LS5xP6XkUzDbJM2uyHnw9tfETLeELCuDc69NhrYZVhxLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844072;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=lXeVdKZgplIsnHrxxLZrBVIeJZ4mQkNiuMtdZoSEMdo=;
	b=Pm/vdXk9kodH/2OJSAsykU2zJs3VBuCDtqhjNV1YJlqFAmJbJc2nCuu0gePzIy/aOn2M
	 JAAHDkGa2qPmO2QK8jjxmnTj6RygPLVHfZJTOQkijUxOpxSZbFfrcBN2DJYmRUlv86F98
	 fnZxSKv7y0Kv5Bqe/Axovqv3IInHKdWMO8LgVjNbQ08AAun+GAXcIm9Ioi5LPyRw9bE8Y
	 6m4wF1QisBkkdWi+PNDqUPJndAMBZT2DoLmkCPZedptoS3fKScKwqKhK+H7fFW26XmOpT
	 TUhqADDSGUL0wvH1jJ2OC7LnbUs+dB5rSnywb82QcqWJSd5+iflhcfOZFl6iJfDy13A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Q0mTKClI;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA5E606A332;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAA5E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Q0mTKClI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=lXeVdKZgplIsnHrxxLZrBVIeJZ4mQkNiuMtdZoSEMdo=; b=Q0mTKClI9VooOYT679tqFrQtl6
	xuCH0mZbWbK+FGnQpTilLo0MkCIpY8grbwbYQEqNuCnyjvdA8+Opdm7YOWLuyX96rDEz6WHzB0JK/
	XaYo0OtsN1p2LxySiL65rwFkuU5lvRSJfdYSbSwgBZ70DANcbpyhNn5R9wZAznZ6+pWWKn4Zv5xKE
	8if70cDKkbabaiNilOaf6GyvgNyXmGzDBwuDNWdxY48W07eIuvmiZNvQGWjD4FJz7vN+RWMZImJ/A
	kykuL6uVDvg8KGxzjzg5WdX31h8n0QVDI0HlaMtdw9Yj0pr2NsDt8Kj4gnEOPpX3gpo3LxZlzHxsf
	me7f1aOA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037j3-0IyH;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDJ-1Lfa;
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
Subject: [PATCH v2 06/20] KVM: x86: Request the guest TLB flush from record_steal_time()
Date: Thu,  5 Nov 2026 02:00:48 +0000
Message-ID: <20261105020104.2507083-7-dwmw2@infradead.org>
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

record_steal_time() performs a TLB flush on the guest's behalf when the
guest sets KVM_VCPU_FLUSH_TLB. With shadow paging,
kvm_vcpu_flush_tlb_guest() ends up in mmu_sync_children(), which can
reschedule via cond_resched_rwlock_write(). That is why the flush
currently sits between a user_access_end() and a fresh
user_access_begin(): it cannot be done while the guest page is mapped
for access.

Raise KVM_REQ_TLB_FLUSH_GUEST instead of flushing inline, and move the
processing of KVM_REQ_STEAL_UPDATE ahead of where the TLB flush requests
are serviced in vcpu_enter_guest() so that the flush still happens before
the vCPU enters the guest. There is no requirement for it to complete any
earlier than that.

kvm_make_request() on the vCPU which is running is nothing more than a
barrier and a set_bit(), so unlike the flush itself it can be done from
any context — which lets the surrounding access be simplified later.

Note that the xchg() must stay where it is: it atomically consumes any
KVM_VCPU_FLUSH_TLB which the guest has set, as required by commit
b043138246a4 ("x86/KVM: Make sure KVM_VCPU_FLUSH_TLB flag is not missed").

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260530061932.7849D1F00893@smtp.kernel.org
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/x86.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6a1f0404f029..3c26c0eb9865 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2117,8 +2117,22 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 
 		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
 				       st_preempted & KVM_VCPU_FLUSH_TLB);
+		/*
+		 * Request the flush instead of performing it inline. With
+		 * shadow paging kvm_vcpu_flush_tlb_guest() can reschedule
+		 * (via mmu_sync_children()), so it could not be called while
+		 * the user access above was open. Requesting is just a bit
+		 * set on the running vCPU, and the request is serviced
+		 * before the vCPU enters the guest; nothing requires the
+		 * flush to have completed any earlier than that.
+		 *
+		 * Note the xchg above must remain as-is: it atomically
+		 * consumes any KVM_VCPU_FLUSH_TLB the guest set, as required
+		 * by commit b043138246a4 ("x86/KVM: Make sure
+		 * KVM_VCPU_FLUSH_TLB flag is not missed").
+		 */
 		if (st_preempted & KVM_VCPU_FLUSH_TLB)
-			kvm_vcpu_flush_tlb_guest(vcpu);
+			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 
 		if (!user_access_begin(st, sizeof(*st)))
 			goto dirty;
@@ -8168,6 +8182,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			if (unlikely(r))
 				goto out;
 		}
+		/*
+		 * Process the steal time update before the TLB flush requests
+		 * are serviced below; record_steal_time() requests
+		 * KVM_REQ_TLB_FLUSH_GUEST on the guest's behalf rather than
+		 * performing the flush itself.
+		 */
+		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
+			record_steal_time(vcpu);
 		if (kvm_check_request(KVM_REQ_MMU_SYNC, vcpu))
 			kvm_mmu_sync_roots(vcpu);
 		if (kvm_check_request(KVM_REQ_LOAD_MMU_PGD, vcpu))
@@ -8217,8 +8239,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r = 1;
 			goto out;
 		}
-		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
-			record_steal_time(vcpu);
 		if (kvm_check_request(KVM_REQ_PMU, vcpu))
 			kvm_pmu_handle_event(vcpu);
 		if (kvm_check_request(KVM_REQ_PMI, vcpu))
-- 
2.43.0

