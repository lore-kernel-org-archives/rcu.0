Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773905;
	b=TXRULO3q78/bTmAYAu+8f54GRcN7G01QwX3RkiFLdjhi/vlLmPC2XVGAvPbtD+O8QBJr
	 GPHvgl2Tz/ZeIPTwFAc6lc57hLz8Ac6pwSW7aoeVNab+TJ1R3ld/A2/9P8nJdWslhCdnL
	 OmNo3iEan7Vf/A27NkliNDX4K6afVc4LmrKCZmCvNFC9nWJ+rPmb6L7d6hssFkBDKk0dE
	 wOacbwv6ddfDLc/73YhM8fA0o/a+w+lAPhRMDveQOwQS0q37tHYGJIPicVK6nxSj+67uj
	 Jsch55vpXCvseUjmhdYBxYqhJ4XKiwbfYHiMgkO5PjduE9HX1SkXwiqK6XWenp92UOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=;
	b=DfjrA6rGhRq5BtYtwtjrUQPiX/aDcuTA2pKTH5BefExOKQQ02hE6xoYb+p/xz4srlP2g
	 HEG4qYgv4pbU/lJajQv5PMQNET/WxKmwMTB2cmOTKuqvdumSAkNVjaCSQAc/+nnm4Mwf2
	 Wcz9P6J0yD5fsCH4kOR7CxLWIbdeItj6kUCPUEUhdRS+yaCO3Hxov8uQwO2++Re1fuc1S
	 jUz+PXCokcXyfi6QimF50L9zCtFA6abiFDpz9pR7Y1r/k0x/OpTOlVJyj033zvnLwCfz4
	 7Qwyjl163lgvX7+ptYV6u4hNwB3agX+meysajxIi3PFhmEvJ63+P4HNxgrLfk3Dtdeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KlMohCMN;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0B606A326
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 06:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3B0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KlMohCMN
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b244fb7fffso566985c88.1
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 22:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773904; x=1794378704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=;
        b=KlMohCMNQP7aBc5dV1ONhQAxlzwBbvcHzvktszAMwHgePmd6cpqQQs1cCdvdz8zCM/
         orn99X5r5zcG7mWOzyoQOwycfney61nVn1pwV0aBiIJrbIFVdFGUgjfMJlqYOobmX8S1
         +px9i7yd0z1sxxXddC75kLl4GrPDjeUBF413dLRnxFL/WOCAKzOG0TADlIrSnn6t3pZJ
         MONALX8uX8ZVcGqmvnQtXQOCQ2PPv32ptawboY2t+bzBAPvxcivSUwAmhwLMBZIGUO3c
         K/PX6EYqY/zz5cGcD7VJR+b31i8GJt4gwMd7i39mK2e11Gc0ty7SssZkfYszfe+xz1+i
         1Pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773904; x=1794378704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SBRMVpxoMRkm0sntL7ZW3fIy24tGYRHmBWm6wUW0LM=;
        b=JNg5XsFXNFDJoTcnam0STX3mPyFlNAJHRLFX6Gw8bgM4vyCLwH8XO1psgZEEtJGwJd
         CKMhOB+FhnbLtXGCYyFxEyXPzuZ9wNHrHSaPpvX8NVH2wPsd0EDZCABlCNVMyXJdygdP
         4znnt1Y6+nvW3kP/wSf433zLEB7OP+sXu7KLlfdtmK/bJh8gyXE/xbPd9vzxprOTzpqg
         2BONmxV6f24f/Ez4trdy84LaikshomvfbOx1qHEBLpZ5Bdq5+8Y3c++xkVhe6OdE7Eoj
         lYyXHDJtYkdJ4hB9gICWe9K8O0pkXVn9lLiz4JPTAfoL9AmsW1O+WrF4DIVdYluoMA8S
         ybjQ==
X-Forwarded-Encrypted: i=1; AKwUvBy157WoQtkalRCqt7X52bpADwTQD9xOiBAfbHsdgFlr30DwsTDg33GckwDVsM0zJJvYKBI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zBc/HmMEpAo09nxvn0HODErg+f5jTj2pGiB9CkWsDz9lojNAm
	vihne0h5xNmXdY79nMjVZUqNdi488EHetmCYQt/4LIISmbI11FvY5iUJ
X-Gm-Gg: AYBFou1JlK/ntbUimsRup9cLm8st/GlvKDOdf85JwmWQAZ2W5l9ZCQ0QoGFdE3qDqzR
	hodmYsZNfJBx9kFz5hG/YhssftVoK4ftsoP3sERIV2J0AXktLMwNbi39c+rIcNMSoLvWNwRUncW
	p2/BwFPB0Nbw2LFeCEFl0wthGxmSA4ZiXq0XAaJtzFdquCQ+IrEPNjpboroXdrsljg6jnT+BQ0D
	uVnv5MY4zW535fQPxl6xNOMNC33qTyUuzE40Mc1tr+Axns0pU+JJv3TGrY7Y7oISdhvxwpowZzq
	ewQVfzeS03o+m2mKBwLlYIBY3wHnS95kPghhLg2w3AB6PTlv6n8tlu0gxL1eLujoFiwjeiQAeUZ
	og6HudsIM7GawvLIwm0hXTeRBmutqRmilzCR+8MdKw/jfAVoR6TMF0CSHXJtvKLLX+9GFwxIfGM
	RAvsYovHu4puspw7legZIWPz5A5YzDbkvZ83zlKFMlL7GjbO0JOLKppFtyKhaGEu4A9rDo18VNY
	BQ5Kg+YsfLtl9xM6CBbC7RTYMsOJfTEwFvUFHh9go3qRs7yCjVqSPoel2mSwdOISS2rUonCryHI
	Qu4G19XRHOTCZzl/2OdJnw9F
X-Received: by 2002:a05:7022:ea46:20b0:1a6:53cc:7454 with SMTP id a92af1059eb24-1ac5d4b2ad9mr25380347c88.27.1793773903877;
        Tue, 03 Nov 2026 22:31:43 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:31:43 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 04 Nov 2026 01:30:40 -0500
Subject: [PATCH v2 2/2] nvme: wait for SRCU readers before splicing the
 namespace list
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-2-feb64ecb96ca@gmail.com>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
In-Reply-To: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

Readers walk ctrl->namespaces under ctrl->srcu, and some of them sleep
there, e.g. nvme_wait_freeze() waiting for I/O to drain.

nvme_remove_namespaces() moves the list onto its on-stack ns_list with
list_splice_init_rcu(), which only waits for RCU readers before
relinking the entries. A reader still on the last namespace then follows
its next pointer to ns_list instead of ctrl->namespaces and treats the
stack as a namespace. Deleting a controller while a Format NVM
passthrough waits for a delayed read on the last namespace gives:

  BUG: KASAN: stack-out-of-bounds in nvme_wait_freeze+0x102/0x120
  Read of size 8 at addr ff110001d2f3fc38 by task nvme/4413
  Call Trace:
   nvme_wait_freeze
   nvme_passthru_start
   nvme_submit_user_cmd
   nvme_user_cmd
   nvme_dev_ioctl
  BUG: unable to handle page fault for address: ffffffff8af04850

Use list_splice_init_srcu() instead, which waits for the SRCU readers.
This also takes the RCU grace period out of every controller deletion.
Deleting 64 tcp controllers with one namespace each, median of 3 runs on
each of two boots per kernel:

                                      before        after
  nvme disconnect-all (ms)            3491 / 3509   2996 / 3165
  nvme_remove_namespaces() avg (ms)   39.0 / 40.5   31.9 / 34.7

Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 drivers/nvme/host/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..cdb576db23809 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4755,9 +4755,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
 	mutex_lock(&ctrl->namespaces_lock);
-	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	list_splice_init_srcu(&ctrl->namespaces, &ns_list, &ctrl->srcu);
 	mutex_unlock(&ctrl->namespaces_lock);
-	synchronize_srcu(&ctrl->srcu);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);

-- 
2.43.0

