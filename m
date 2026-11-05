Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844071;
	b=O1th+aQp6OT3P5PBXZwiXxArlJtrblsv2xLmRjvCBglwxVeupfl4Jdhcg+vN7GX45nS4
	 6AhKhWjohIbxqfoUIqtth1LvxaQbMpGof9CUAS/DOnLDy4EtTXnAQoSE9NQKZXCBc6qLm
	 xYDsKz8sHwzmLjGFdNBl+2ZOZr9J/6wSSaZ5WHXnZLAl+kGPQQnKCLFYsvLs6nWcOKFrw
	 9Vum+rvht35TR/RmFdo8xORBNRXLeFhC0J+zuDEAHQSgHy/7Jpa0FMJDexGJ/d0dN7dja
	 tDW+Q9KjdyvbLB7W7kof7H7FOMVPnF3N16cfCxQp6OeQLXnsLyPNksZMtetgX0dvnOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844071;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=lwhWK78aKBCZA+QaUNKsEkehxG8l623JQyS+IL7qpjA=;
	b=LpwjvyUcE3Cp5CW5F29tbKJyEc3HwdarOvqykCg1MqUYi+k1wR4gMQR7o8IzKaIqpBzo
	 M4t8Iawm5WEDSmrs0PpavDVOpDsqgyEWgvYkdCJ8RTTOGwYNl07V6uRo4e5uIu3FuPg9t
	 XgdXDrz1Hob32zWhAlPSD9Py1Giw/bovvEwKLXUoRuGsyjgJhb9zLcmvgNP8s+XlBjWzR
	 Zssm/wQR1eVwPF3nbFpg9x8R7sVa7DWKgd29s/Vf1j44n8Ifl10hJt9P8srT2JlXSoJIA
	 /IHAeRvamdaER5a8r6VZZjrh36F83a0fdfaRmMyKKJ2Ejjd75ARRGP1kd3LSz9FLwYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=n8WkuTIU;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CB606A32E;
	Thu,  5 Nov 2026 02:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA9CB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=n8WkuTIU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=lwhWK78aKBCZA+QaUNKsEkehxG8l623JQyS+IL7qpjA=; b=n8WkuTIUJBAEQLjaPqryS5ggCl
	y26l0X14vqxw718ZEtCq79SsSiA3OnMAVSMEjK1rF0ZVRMizKHjmNfBVE34V2CDiw6ty3ekC/1coo
	Puv8PqQzow2JBcn/eyqjUN/e6nt0/lZXDkjoTvECAqi7kmuXsB0tMZE6CEtfcnybTDYTYAgOmIqs2
	PL7l3sokUGAUH7FjWGiLeMtD0nxKN/c/hU7QlyX+31PQYkih3kaogc7KUI81DGy1+dRPpYkhl6y/z
	iyMwF/EB2yZ5PT5xKjFakTTUeamZR9CLG3g7vma6bqzUzaQATSq8T8nxnnknhgYvJWDNBaJhC20cw
	qMpOOAvA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmmn-000000037j5-0GGC;
	Thu, 05 Nov 2026 02:01:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xOmmm-0000000AWDM-1U12;
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
Subject: [PATCH v2 07/20] KVM: selftests: Actually deactivate the HVA-based shared_info cache in xen_shinfo_test
Date: Thu,  5 Nov 2026 02:00:49 +0000
Message-ID: <20261105020104.2507083-8-dwmw2@infradead.org>
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

The "deactivate by HVA" leg of juggle_shinfo_state() uses attribute
type KVM_XEN_ATTR_TYPE_SHARED_INFO with .u.shared_info.hva = 0. The
hva field shares a union with gfn, so this activates the shared_info
cache at guest GFN 0 — zero is not KVM_XEN_INVALID_GFN — instead of
deactivating it.

The juggle thread therefore cycles through an unintended fourth
state, with three consequences:

 - Every "deactivation" splats wallclock data over guest frame 0.

 - The HVA-based deactivation path is never tested at all.

 - In the TEST_LOCKING_POLL_RACE phase, a SCHEDOP_poll which samples
   the shared_info in this state finds evtchn_pending[0] bit 0 clear
   (the real shared_info page has it set; frame 0 does not) and
   blocks in kvm_vcpu_halt() — the only state in which that poll can
   block, as a deactivated cache fails kvm_gpc_check() and reports
   the port pending. If the timer event is then dropped, nothing
   ever wakes the guest and the test hangs.

Use KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA, where hva = 0 deactivates.

Fixes: 9397b5334af1 ("KVM: selftests: map Xen's shared_info page using HVA rather than GFN")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/sashiko-outbox-177931@kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/x86/xen_shinfo_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index aaa414c677ad..fb3c834c7cb7 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -410,7 +410,7 @@ static void *juggle_shinfo_state(void *arg)
 	};
 
 	struct kvm_xen_hvm_attr cache_deactivate_hva = {
-		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO,
+		.type = KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA,
 		.u.shared_info.hva = 0
 	};
 
-- 
2.43.0

