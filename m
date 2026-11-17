Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794897069;
	b=iZ4VjZTeGZLK754tbjkkFYIBKCHm0gKk/28j/JC9AynTR0pZMM8Nwf1YpY7IbqtjZdCm
	 Cm87m/BWZFKZp0X1rbkMgJeEfhSv0E/xIF7SJOHBtpr9lV9yrh4Lx07k9JCyID0ognh/B
	 F8mXK4ULZ9Xp3Zv374dVJTvKjJSO07UPYB74E2T82sB1P1y5kJott1akZuD8Biqm/2aoQ
	 ImjWC8skppnP7/xw/pscxe4wtO3CbdS+XMSMOGgk7P9eFgEDv0UixxUNCA/wCKZLH04h7
	 W1n5hp+IKINnfubgpEr8rV7n33y+uPWgRZbbogRwY2Qm62sAGrDr5CQ9JRY0SkrxnTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897069;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eIl02sFeg/HdcCOnjAF4dR6Ki4InqJhsRRcDiPV3dRw=;
	b=veBLzRrxhl06JzIDzEdZRYLtBz/Ft6ASgEQb+5JsoHyVlARozp+O7UDwHCqKgI4OMM2z
	 GOBWh+m3UFJ2OwJvGIQ01hHcgmTZUnVmta6R8xcykN8N1KjJRNR8gR6l8VeIKw9GgmKc6
	 eKfwaXCFuqT52CcCLsHgP0z/7sqxJHTKBb30+NDpHc0Yq5IefaQUVXXSQgjKHQjR8aUsp
	 AKazBjZQ3dJVedVuP9OC6nF91R7txSP5E6niRu1H9jBGByAceeS57d3UH0Qb1gc2vkY3o
	 1gH2X3IiUvvc86xoXZUHB9Pyia5br9AgumwfxxQ5rbI1Pmb0zuzXKkWqOY2ZUuGVpzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=A8XBF+Au;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DE606A31C;
	Tue, 17 Nov 2026 06:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E0DE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=A8XBF+Au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794897062; bh=eIl02sFeg/HdcCOnjAF4dR6Ki4InqJhsRRcDiPV3dRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8XBF+AuOXu/OlZOM0GSLMXQEejSTyFW7UvXGK/E2ZvNZ8ZOpaiBrC9s2IrD3HMqI
	 T4m7Cz5Lgs6zVtxYb0eGXb/M3BSRf+u26YcnHjQ8NFBEM3hZezNM9d5AFN5eMlLAAK
	 tvq1ERW3vNd81dnu0fG6koBrHDisEWbRUYoqmQfs=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 7C094836; Tue, 17 Nov 2026 14:31:00 +0800
X-QQ-mid: xmsmtpt1794897060tqp7f3i2f
Message-ID: <tencent_E038DD9BFA4429F88047A5A4367D578DB80A@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GL9JzXXpiC7azFNOkDpUo3/vpjdlF4rKkk08frouJPI9PVkBbwi
	 bqqy6N4lnb/qXJVAhhemt46o3E0nDPq3eyEUNeIhttIcuRH0bHMlOggB70bCwFJUrPuIMlfyp3mO
	 F11RzHHxEnAANvNAD6am9RjfGqGDHX5lwZG6zyiEewYlF7m19wUmxRu+kWqPwPyhi/5kRYpyUx0u
	 POphp1wlewIrauVYLNRUEOrS82qnyi/HUdtQO+WiWSTIiWhg9hJexvOcaqYqKjn2+eD9yumF8TI9
	 9U1AdEXd5SoqZxWyEn8V2b+VRCZ/tQO4pVEtcdd/FX8OxWRkcejHWecVHUrR6IqdxwMADCVUsUAo
	 nBcZ3fuj5sJKV0rwZPVSPEtaegu2oCRKv4grbEExLE+HGbqswhZ9UkpDHr9z24RPE//X5NmBfw3u
	 LhUadZTk4vGTv4yZvnlyyAJ/FKof0aDrVac902wPeVJz7c4HSHmOvri0UaO2Pdk6PNqv56/IpRB4
	 4KFFEpkczxYOsrMTV0N2rP526MBB97zVq9Va30exKkgsgV2JPxGKOPju6FXuJkVdzgzLjVyRF9ab
	 UR0O9BvoEw7rKHBz1wwdJupAYUfjA4fw4/O6iajIpPxmq3CJJRmyce8D/4d88s8pD+GO4hFwVCQN
	 jRltQSR/XOj1ocLQ+EzxZ0WW8z9eICRVbpXLNDvCKXmLsx6liWCR/J13+z+ER3NWncg5sN5GwsDp
	 t/G4aTTDzwBgsaF9FQhTQHPlsMzv4lCRBcO2HySo8oMFtrkr3n3uDcP3qAFDW1c5G/++PtxE7fOF
	 bBXWgiAFDomdn2cxTlzf3IB9kw+qnW3BxgsqDcO4zVe9GdChYDv8PZsdThVMvXEi2I8sg/9WZqTR
	 5MvELSSRxq11OJY4OqgTyOIJgblsNk7X8UPMRwI3cw3ITzeX3c3LO4Cj0GjLK3HN2j1OeXN0m8h6
	 a++aa5SNtKyxJewepQbQ7QXiIVrRVFXWQy33RK8MEQeLJ73j9F6Uycf5I06jAk4QF0MaVFywNKU3
	 +kNazF4NjnfaFBG0Zb6F9J2OQIDz4VbOvInXlJlPzYRHLteVCJ5BnTi0L+ywQDz1BTHtQsL+adcu
	 QYO6A6
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Guikun Yang <yangguikun19@qq.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH] srcu: Validate ___srcu_struct_ptrs entries against the module range
Date: Tue, 17 Nov 2026 10:00:00 +0800
X-OQ-MSGID: <patch-srcu-within-module-20261117@qq.com>
In-Reply-To: <tencent_0836A27053A7BED946E49CE04D27A31E7D09@qq.com>
References: <srcu-struct-ptrs-wildwrite-20261114@qq.com>
 <tencent_0836A27053A7BED946E49CE04D27A31E7D09@qq.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

As discussed, here is the formal patch. Exactly as you presumed:
srcu_module_going() needs the same check, because a module whose
coming() fails the validation still gets a MODULE_STATE_GOING
notification via the robust call in prepare_coming_module().

---

The entries of the ___srcu_struct_ptrs section are absolute pointers
emitted by DEFINE_SRCU() in module .data. load_info() hands the raw
section to RCU (kernel/module/main.c), and srcu_module_coming()
dereferences each entry and writes through it:

	ssp = *(sspp++);
	ssp->sda = alloc_percpu(struct srcu_data);
	ssp->srcu_ctrp = &ssp->sda->srcu_ctrs[0];

A malicious or corrupted module image can point an entry anywhere in
the kernel address space; nothing on the load path validates it, so
this is an arbitrary-address write primitive (an 8-byte percpu
pointer at offset 8 of the target).

The static-key loader already handles the same shape of section with
a range check (kernel/jump_label.c):

	if (within_module((unsigned long)key, mod))

Apply the same check to both module-notification paths. coming()
rejects the module load outright; going() skips the entry, because
going() runs even for modules that never passed coming(), and those
entries never got per-CPU data allocated.

Signed-off-by: Guikun Yang <yangguikun19@qq.com>
---
 kernel/rcu/srcutree.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 2b0e2b2d2..412265757 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -2498,6 +2498,8 @@ static int srcu_module_coming(struct module *mod)
 
 	for (i = 0; i < mod->num_srcu_structs; i++) {
 		ssp = *(sspp++);
+		if (WARN_ON_ONCE(!within_module((unsigned long)ssp, mod)))
+			return -EINVAL;
 		ssp->sda = alloc_percpu(struct srcu_data);
 		if (WARN_ON_ONCE(!ssp->sda))
 			return -ENOMEM;
@@ -2521,6 +2523,8 @@ static void srcu_module_going(struct module *mod)
 	srcu_defer_flush();
 	for (i = 0; i < mod->num_srcu_structs; i++) {
 		ssp = *(sspp++);
+		if (WARN_ON_ONCE(!within_module((unsigned long)ssp, mod)))
+			continue;
 		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
 		    !WARN_ON_ONCE(!ssp->srcu_sup->sda_is_static))
 			cleanup_srcu_struct(ssp);

-- 
2.34.1

