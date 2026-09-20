Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744F476CE0;
	Sun, 20 Sep 2026 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789940228; cv=none; b=mNmWLbClSYaP0CBPrWRautSPCRJGBemR2dGs3bHLRRFaSV7r/T2vn0a4McCwbVEjIwcYyUVIZrsDYebOiaXvsX7a3psKU7NFkPjwM9TTA0z5Ip6GcTacjkzitpk200U+CoF5eKKxOhhrrMPPv37rsMSnuBXjMFh0TkW9f9k/jcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789940228; c=relaxed/simple;
	bh=Sqz4/gfWMMZ6WuS2rfU/GpF8SlJSf5jby57E5PvmZHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBUGTjWTXdNIP5CuvMPOUbZGvxmr5n2foQzMuORYbbPGZNXOz0KFbUAtVI+01RXl4jrdZLW8eKj/CL7JUD1hKFPlw85JMOKGk1C7anCQZAigRPSObxhxxORxV4qld2MwXbkh4BJrKg2hxOKuAs1ApCDJMWJVtLEjVD1ryzBNH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q0XToOfq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0XToOfq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=nmdHWM2UedH6PKA177/u7y2y2c/nfWgsVQXatzAGzlw=; b=Q0XToOfqSj0s/rtomChxCq8cu8
	BmPVHYQmOFrdt8JIvT2zOF5ZC7zzC7MzGx0S7eyq1uqTTrx2EGuX498e2YmVPCyJZokQRjF5PK81O
	6XSsbb5V2yH8kAldGAVpRpsLX6KhlpE+iYAmF8joPeVHy/XyQBWwfSOs6JQgR08j17AtbrZTRzfri
	9/BFWOab7MkRXthbMYSrQePWzWlW7yUXG9XsM85kU8D15uJxG3tjIGQXYhpa2jlcJWIlE45jQj4u0
	Umg3fCb/wXngQSAsynxzWXIQfOUSOKWKIoc+ScCI8k/OL4Zoxj7JIiUy1yfAovS2aJ86sccWiqxw8
	1G7dbRAA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8OwU-0000000BLpx-3MLT;
	Sun, 20 Sep 2026 21:19:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x8OwU-00000003tcr-2Msu;
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
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 08/17] KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid memslot
Date: Sun, 20 Sep 2026 21:49:36 +0100
Message-ID: <20260920211920.928306-9-dwmw2@infradead.org>
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

A memslot being deleted or moved is present in the active array but
flagged KVM_MEMSLOT_INVALID — a transient state which exists only
within a single KVM_SET_USER_MEMORY_REGION call, resolved (or
reverted) before that ioctl returns and announced by a further
memslot generation bump. gfn_to_hva_memslot() collapses that case
and a genuinely unbacked gfn into one error, and the pfncache
refresh reported both as -EFAULT.

Distinguish them: return -EAGAIN when the slot exists but is
invalid, so that callers may retry — mirroring what RET_PF_RETRY
does for ordinary guest faults on an invalid slot — rather than
treat the gfn as unbacked.

For most consumers no change is needed: check-at-use sites (vcpu_info
event injection, steal_time, pvclock) skip the update and self-heal
on their next invocation, and treating -EAGAIN as any other failure
is no worse than before. Event channel delivery is the exception:
abandoning it on a transient refresh failure drops the event. All
three producers — userspace ioctl, guest evtchn_send hypercall, and
eventfd/irqfd (whose inatomic fast path already punts to a workqueue
on -EWOULDBLOCK) — converge on the kvm_xen_set_evtchn() slow path, so
teach its retry loop to keep going on -EAGAIN. A guest send racing a
memslot update now waits out the update (with cond_resched()) instead
of bouncing the hypercall out to userspace.

Where a userspace ioctl performs the resolution (e.g. setting a
vcpu_info address), a concurrent memslot update in the VMM's own
other thread now yields -EAGAIN to userspace instead of -EFAULT:
truthful, actionable, and only visible to a VMM racing against
itself.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: Claude:claude-mythos-5
---
 arch/x86/kvm/xen.c  | 12 +++++++++++-
 virt/kvm/pfncache.c | 17 ++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index b6643b889320..0b49eb67d06c 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2026,7 +2026,17 @@ static int kvm_xen_set_evtchn(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		idx = srcu_read_lock(&kvm->srcu);
 		rc = kvm_gpc_refresh(gpc, PAGE_SIZE);
 		srcu_read_unlock(&kvm->srcu, idx);
-	} while(!rc);
+
+		/*
+		 * A refresh which raced with a concurrent memslot update
+		 * (-EAGAIN: the slot exists but is mid-DELETE/MOVE) will
+		 * succeed once the update completes or reverts; giving up
+		 * instead would drop the event. Only a genuinely unbacked
+		 * gfn (-EFAULT etc.) is fatal.
+		 */
+		if (rc == -EAGAIN)
+			cond_resched();
+	} while (!rc || rc == -EAGAIN);
 
 	if (mm_borrowed)
 		kthread_unuse_mm(kvm->mm);
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index e15d9a475fed..29397ac02668 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -681,7 +681,22 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 			WRITE_ONCE(gpc->uhva, gfn_to_hva_memslot(gpc->memslot, gfn));
 
 			if (kvm_is_error_hva(gpc->uhva)) {
-				ret = -EFAULT;
+				/*
+				 * A slot being deleted or moved is present
+				 * but flagged invalid; the lookup failure is
+				 * transient, resolved when the update
+				 * completes (or reverts) and announced by a
+				 * new memslot generation. Distinguish that
+				 * from a genuinely unbacked gfn so that the
+				 * caller may retry rather than report an
+				 * error, as RET_PF_RETRY does for ordinary
+				 * guest faults.
+				 */
+				if (gpc->memslot &&
+				    (gpc->memslot->flags & KVM_MEMSLOT_INVALID))
+					ret = -EAGAIN;
+				else
+					ret = -EFAULT;
 				goto out;
 			}
 
-- 
2.55.0

