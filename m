Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB747ACF7;
	Sun, 20 Sep 2026 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940273; cv=none; b=i65oyvFUu2lPTNRDlUT1qFtHJShCk6SXQ9+Y2x8fQdbffwFvjIVxpNT9E9t/PL8D18rC1tEYY1z531cNTnSk1pVe7BRsphhkgv0ZzNQM4956hMtqf2Zqt51+wcFG3xe1Arh2+cgq8hV56qiEZFMEreD2aPpStuPvt9+fctsBGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940273; c=relaxed/simple;
	bh=9KfDxHG2yl46u03Z+FxS3cEpcqm8xfTlnu89nLZcEMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AV71nsFGaMlepa3Y1ou0pLAE12HVQ2CB6yMPoRgQduCc/o7x1mJd/2mhWEOzKCwMM+FGaqn29eI1filvQJhohdHW9Rd2SUnfWG7oAbTdvIU3RVDtw3zP6OFJQUBMizo0MveMLhb96QT9o+rWS78H4Iu1bmOubRWQY5jDiBCK0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VU31gNJA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VU31gNJA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=TR0E1ViaC+vgzkzq3tRVZr9hLoobpJbHc35aSaZZvgE=; b=VU31gNJAldPY8k6TMFswaPMVEz
	LYdqEuJA1mMBPeaV4wHVJksSiG93FjVOfh5l3InzcIonDtkgEVHrNJB199n2mV+IF9XpxseRI9kZd
	KXv5ErrMwb8xTROcFxVC8+do+YH+ExmFV8JkzQQH0ksvyPRyTVK9qITRF2CfbnEpeMtdKCktf9dcK
	AaYT8wh2E7pA7iB9LKVsCBaHk5AP3LCxgw8ClbqGg/qewHNT1EUTnHP8NvKDfKtuIGyHUp78nvTqf
	sMKlMm11zOP5YCQIVy2MBpL4QhyyRnBN2V4abREOx7lHTTOa6IusM9Enhg+tFAwIqXtO2Mvm/gS68
	gzfUXB8A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwU-0000000BLpu-2c86;
	Sun, 20 Sep 2026 21:19:22 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcf-1Zyf;
	Sun, 20 Sep 2026 22:19:22 +0100
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
	David Woodhouse <dwmw@amazon.co.uk>,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH 05/17] KVM: x86: Request the guest TLB flush from record_steal_time()
Date: Sun, 20 Sep 2026 21:49:33 +0100
Message-ID: <20260920211920.928306-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920211920.928306-1-dwmw2@infradead.org>
References: <20260920211920.928306-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

record_steal_time() performs a TLB flush on the guest's behalf when the
guest sets KVM_VCPU_FLUSH_TLB. With shadow paging, kvm_vcpu_flush_tlb_guest()
ends up in mmu_sync_children(), which can reschedule via
cond_resched_rwlock_write(). That is why the flush currently sits between
a user_access_end() and a fresh user_access_begin(): it cannot be done
while the guest page is mapped for access.

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
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/x86.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ccca707d768f..3db1855aba79 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2106,8 +2106,22 @@ static void record_steal_time(struct kvm_vcpu *vcpu)
 
 		trace_kvm_pv_tlb_flush(vcpu->vcpu_id,
 				       st_preempted & KVM_VCPU_FLUSH_TLB);
+		/*
+		 * Request the flush instead of performing it inline. With
+		 * shadow paging kvm_vcpu_flush_tlb_guest() can reschedule (via
+		 * mmu_sync_children()), which is why the user access above has
+		 * to be closed before it. Requesting the flush is just a bit
+		 * set on the running vCPU, and the request is serviced before
+		 * the vCPU enters the guest; nothing requires the flush to
+		 * have completed any earlier than that.
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
@@ -8089,6 +8103,14 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			if (unlikely(r))
 				goto out;
 		}
+		/*
+		 * Process the steal time update before the TLB flush requests
+		 * are serviced below; a subsequent change will have it request
+		 * KVM_REQ_TLB_FLUSH_GUEST on the guest's behalf rather than
+		 * performing the flush itself.
+		 */
+		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
+			record_steal_time(vcpu);
 		if (kvm_check_request(KVM_REQ_MMU_SYNC, vcpu))
 			kvm_mmu_sync_roots(vcpu);
 		if (kvm_check_request(KVM_REQ_LOAD_MMU_PGD, vcpu))
@@ -8138,8 +8160,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 			r = 1;
 			goto out;
 		}
-		if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
-			record_steal_time(vcpu);
 		if (kvm_check_request(KVM_REQ_PMU, vcpu))
 			kvm_pmu_handle_event(vcpu);
 		if (kvm_check_request(KVM_REQ_PMI, vcpu))
-- 
2.55.0

