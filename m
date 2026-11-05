Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844071;
	b=4jZdBQja2CCufCPPAaFUTQoiEtfy8/nqw9NGayDxk2MOGcTtsZuDdJxSflQ+LDNXVtjq
	 S9Ob5uhbK65UsFIDtcWR6HT28o01rWIbJCx4qDdWOtIe0bf/AGA7he6eBu334qpiGptLQ
	 g0d0ztmZ5UPRfKXB74aPNQ6n10e9otjbdJpExSshGkBaBb8hBQO77r7B867bYXFDx9lJz
	 abmjhNVQhcz3AWU1KTV+WtGs2CW1d55wJ9E3rKyoWAI7bicuHxTT9fAiw20fGt5Goq6DR
	 s4ZTLo8ncUZMekmemDkc95/hKQEa5IWEO3eXZnfn7KmaciSH7WxfWQw6+35Hae9fRSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844071;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=xWajFXWJuXrJAKbtDPmQO5pr3uDz4D2E84mtmYB7ov4=;
	b=gXU05PTlXrsj37KTehux6QjDp+Ee5N1YIqdQhY6aWMBcAHTm+6F51Dqk7DUsjPKrRtD7
	 /KnkDSwfHJNTVUUM5m9wH2JLBScAdPN3HVWkB6O7ux2sFOyO/i9wpRGakz31Yu6IfDaiD
	 TYAwwhNoslHSSTz+NEMY/HhyZelqTcESMwlTt6YZXde1uRHSGFA8TWV5m4/wLA/GDq1iW
	 gYgaWA2O8Ug6KfB27AeyRKu1wfyeOAzK5dEzJFj+MXbYaDPVYceyRLM3H5alTR1bBJuaA
	 eDS93RgJXvEsT0Y4uBfjXnAYP0VRyHH248QdjQMYUc9RvlLAlbLsiFVpX5EYJE6nRQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=CgaDSHDY;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4A606A337;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB4A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=CgaDSHDY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xWajFXWJuXrJAKbtDPmQO5pr3uDz4D2E84mtmYB7ov4=; b=CgaDSHDYP24zDUkZZWqry3n+XW
	Ls4wgdyfS5KdZRdyHotvJlWydY5wyGPFx+/mA5yY2cEZJLSRlJIRQGZSBZ6/Dy1kY7/E27Z6TiiWv
	UPOezUssoxV5mGUXGBfomkcvTDpnCspYIcEKZoYbOSA2j3xXCQZfd5CKGZw2mHr0yuE6E5TkRblRI
	5GGi9rMgYbiMv77gmysNS8FRowdkf6WQnYexSzPNbWql5VO8lcvPfMgF78nfXaNFQHEaOwKhPqfh2
	5ZghbuuxdzH+GHAjHbuXA1OJDaBEArYsrTuKzD1pFDjyXTaZfCU0FZN5TBajF0+uPNchZi47YBi9I
	B/rGPOsw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037j7-0HhA;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDG-1DI6;
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
Subject: [PATCH v2 05/20] KVM: x86/xen: Don't dirty track "vCPU info" page
Date: Thu,  5 Nov 2026 02:00:47 +0000
Message-ID: <20261105020104.2507083-6-dwmw2@infradead.org>
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

Give the Xen per-vCPU info page the same treatment as the per-VM shared
info page, and never mark it dirty, as KVM clearly relies on userspace to
assume the page is always dirty.  While the page is marked dirty on writes
via kvm_xen_inject_pending_events(), it's not marked dirty when written by
__kvm_xen_set_evtchn_fast().

Furthermore, as was the case with the shared info page, writes in the event
channel fastpath may be done without an active vCPU, e.g. when called via
timer callback or irqfd injection.  I.e. attempting to fix the fastpath
would run afoul of the same issue that was fixed by
commit 55749769fe60 ("KVM: x86: Fix wall clock writes in Xen shared_info
not to mark page dirty").

This also covers the pvclock writes kvm_guest_time_update() makes
through the same cache; userspace assuming the page is always dirty
covers those equally.

Signed-off-by: Sean Christopherson <seanjc@google.com>
[dwmw2: also update the KVM_GET_DIRTY_LOG note in api.rst, which
 named only the shared_info page]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 5 +++--
 arch/x86/kvm/xen.c             | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 70818f1353c3..6f0500f7ffe2 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -385,8 +385,9 @@ The bits in the dirty bitmap are cleared before the ioctl returns, unless
 KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 is enabled.  For more information,
 see the description of the capability.
 
-Note that the Xen shared_info page, if configured, shall always be assumed
-to be dirty. KVM will not explicitly mark it such.
+Note that the Xen shared_info page and vcpu_info area, if configured,
+shall always be assumed to be dirty. KVM will not explicitly mark them
+such.
 
 
 4.10 KVM_RUN
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d3773416cd44..e54988522b8b 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -706,7 +706,6 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 		WRITE_ONCE(vi->evtchn_upcall_pending, 1);
 	}
 
-	kvm_gpc_mark_dirty_in_slot(gpc);
 	read_unlock_irqrestore(&gpc->lock, flags);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
@@ -2464,7 +2463,7 @@ void kvm_xen_init_vcpu(struct kvm_vcpu *vcpu)
 
 	kvm_gpc_init(&vcpu->arch.xen.runstate_cache, vcpu->kvm);
 	kvm_gpc_init(&vcpu->arch.xen.runstate2_cache, vcpu->kvm);
-	kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm);
+	__kvm_gpc_init(&vcpu->arch.xen.vcpu_info_cache, vcpu->kvm, true);
 	kvm_gpc_init(&vcpu->arch.xen.vcpu_time_info_cache, vcpu->kvm);
 }
 
-- 
2.43.0

