Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844072;
	b=0mvPJ4oiyXa23EEUVogA921T3CveBck2HaIiLzaCmjOJY5n8fLEdd1Lxb8wcrar1XkQZ
	 3J72mzjUIeXPSLtJbbdCUE/aKYlyY+bt1HNOrXpafLgfnmIzgkzC0l3dbRxcW8zdwLoTC
	 +HD3JbJ+gjPxJabwHq3SVaYT4JMaU0n0qM/frUDrhWkSOemtRA+vjiq5hG1EMWzG/GB4f
	 uaJSCndAR+Yyv/Q8OG39y08DO/IdOpRRofAqxBcVCLu8lwrH0L6zTzaDxVyPNaBGQxAWH
	 ej+p9N4BBtHLp8WuQcqIz6/IhQxxdDcSYtn3olqj2OuEdm7VgKNv/v0lm9iC2p2Xd0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844072;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=KSzhuJP/1dug5WU6DX/hxQAI8dWQXM9qoEPSMrGRfhc=;
	b=TU69fsDzpjNqUE9uAAu3no/J7fTWDVrkWkM/SLs0pt6qi+MFdzCrzU9Me+peDkVChipN
	 2SnqbG4xbWZ6vU3QoV/ujWVEFEay+CyLzFzjU+q042wSdu2tmt+rDBLSfO43kU+UfqbdZ
	 2e6fRqTKVOGjV6HD6fNI1ETC6C0C5m56FLneCkLi6RBzu+kkExpoidShnThS1rwlYWpPO
	 O/pS6Ue1UldgRI0wNubpQ4FdCZl79kWT4z/grsqzLQ0sdS9IHhRCOyouBcD7PT/uj168N
	 HcHEaMHCzX6dnljXNQ7Z1LY0qrljZbZ2iwv/Cgi6fa/mfrdt/PmpctWr3WXeLApnBbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=sSLM+wEZ;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB75606A338;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB75606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=sSLM+wEZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KSzhuJP/1dug5WU6DX/hxQAI8dWQXM9qoEPSMrGRfhc=; b=sSLM+wEZ0RAGrshJ0WnfiNFrWB
	0PW7Qwl4biKt2CKvniyPtUPM/+KKY9PJarIrJJAl+cmqTwUrVJTfjvnengZfBWJENxvpBWGDn/gY/
	pecfLTM7auTFS1/xave/ZteSyGl/spAUl9WzVckvvarfbdD63e7HRnMzmNOzkP7iXmV4CLZl8urHt
	DHQMmB3EjcA6NbwiJ6rf9dKzCF7QVX8tOEFYMrUFTwV7HkAXj0UY3KETf0gvd6qswDsAw6lHHo9dt
	vuYvNawUWAdXlNbz2kj8DlKULI0mfEdULeoJTVwrCCUpCCbG/uKEnuN3exUJOpaPtdERcZ2pyHuxp
	n+9w8nRA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037j9-0FHW;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWD4-0WQw;
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
Subject: [PATCH v2 01/20] KVM: x86/xen: Fill the hypercall page with a single guest write
Date: Thu,  5 Nov 2026 02:00:43 +0000
Message-ID: <20261105020104.2507083-2-dwmw2@infradead.org>
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

Writing the hypercall page as 128 separate 32-byte guest writes pushes
128 entries into the dirty ring for the same gfn. The ring's headroom
above the soft limit is KVM_DIRTY_RING_RSVD_ENTRIES (64) plus
kvm_cpu_dirty_log_size(), so when the CPU assists with dirty logging
(PML adds 512) a single WRMSR fits; without that assist (e.g. VMX with
PML disabled) one guest WRMSR can overflow it: a guest-reachable
WARN_ON_ONCE() in kvm_dirty_ring_push(), and an unharvested entry
overwritten, losing a page from dirty tracking during live migration.

Build the page in a buffer and write it with one call.

Fixes: fb04a1eddb1a ("KVM: X86: Implement ring-based dirty memory tracking")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 6aa00f746cba..5875d10ae3a9 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1345,7 +1345,8 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 	 */
 	if (kvm_xen_hypercall_enabled(kvm)) {
 		u8 instructions[32];
-		int i;
+		u8 *page;
+		int ret, i;
 
 		if (page_num)
 			return 1;
@@ -1362,13 +1363,20 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		/* int3 to pad */
 		memset(instructions + 9, 0xcc, sizeof(instructions) - 9);
 
+		page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+
 		for (i = 0; i < PAGE_SIZE / sizeof(instructions); i++) {
 			*(u32 *)&instructions[1] = i;
-			if (kvm_vcpu_write_guest(vcpu,
-						 page_addr + (i * sizeof(instructions)),
-						 instructions, sizeof(instructions)))
-				return 1;
+			memcpy(page + (i * sizeof(instructions)), instructions,
+			       sizeof(instructions));
 		}
+
+		ret = kvm_vcpu_write_guest(vcpu, page_addr, page, PAGE_SIZE);
+		kfree(page);
+		if (ret)
+			return 1;
 	} else {
 		/*
 		 * Note, truncation is a non-issue as 'lm' is guaranteed to be
-- 
2.43.0

