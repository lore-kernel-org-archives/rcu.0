Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773850;
	b=gMfTY6llkUr7E3IKdO9qK2Ey3hYfk2PsnL/gMqr2+7Hho0FRNkSAoMNBiH/+10GFGHfz
	 9c0xOiNarE0jJTCNm7KTCNFPNLf0H6bs4/7efl4xbRHIbfLZiv4IjYX5gW41S6xfyeluW
	 BNiSuvSgpSnkfMJ98N3U2xxISC/3vjrl+3Y+QmPUEAkabpjXDlq4HQwUEOQIj+j3jWAke
	 FUKxBqf89X7rf93XX90ieiIObzdJ+CYZoURkleYSzFJpaaRu2J16TWItMDOTlgnQV60ev
	 F2E75/NbMII8LuYwgARsV7gAM/JfpAbqOn0s2R53GqlLx/IJN2Kp5hYunw/Wp15SIXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=;
	b=RuHdaFvUmsbYQtqUqHZVS2eP05E+WIQP86URYI+2+3xzfIdEWvcMxiYBJJC/aF+4X2bB
	 a+MA8fCt/aOl2CFOaijbbKbRjGRTYZMWRW/4azwHBvS3YsfhxHTem9b5fa1rxDNPROqpG
	 UNv9RScsCWg6NqgFa54rytuyrIAvYk5RwhEqU2SmDk/htEKxF0J7tz10RmdbHNT578GSe
	 7i5VjOOjX3yvoSyVuOUPygkwRy0/bldaeGy7otDg5Ebkv76yOJcS4pduE0YTSAACYMump
	 7e1S2nnxmYCApnYAv3nBFqqR+mprNRmSdXzTLd7oTpxImpbP4VKzETFiBts2kWDfT4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ge4DWC8p;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31324606A328
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 06:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31324606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ge4DWC8p
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so667932eec.1
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 22:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773849; x=1794378649; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=;
        b=Ge4DWC8p50yuM6BE+AoH2DbZIelL+VUSCXwsaeYpNMsz+PTDS5TIsx+Ou5S/TgXiVh
         6D1P5MbAyNcBV/bo2HUR2y0Z2ydBXauksnTzGC4WhxPaQnLcKMmyBGjQ5ZioZiZwuNHj
         4fTdv6uegGxFf6rKf1KgtgcPTKrMsqB+91iNX0TORH+nTrFBoxsWLGRnTqWPh66cEMIY
         VcewTJ3nBkopOLEfJa5O66Jd0tDdAcIpxqQdbD76B+5sST3paZaHiMlMNqZRRXjreAcs
         6NsKlfG57u+AzUzzqLvdXv74xIlgnbYpc7EgvHfRGjn2ILvxfoD23xNW0LCUBbnwwMgW
         zk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773849; x=1794378649;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mw7VJYnNekK0b04jd3U00XO5v3TzXJogPpVwvYNW6MM=;
        b=AXsCPReXKWIVYTOXt3g1S6V3zkvOQ5YvPB5mRlB2j22+xAkSEQ54wpAN0tF0XeLo9L
         QAimSCeBlQL4LiLJeceZ0zEpCs0SJjrgZJQpkVqL8LFC2c8B+wm6RPJJeVMrfEs9M6+c
         6HXzxH3jl814AczEOgyeSUxtqiq5Wd4trbzF5T6IuuCvmC7N/RcEUx9FKQzY9iBBNmIO
         2cMGXoQTj7n4dUxJLvf3X/fjGsxxt/4N3yz7vwgikyhDQRLv6xYjCCX+t8GYRRh8tH0e
         xt3YYXPE7ao6waETw9osi1Qe5YSwJwZeSd2TjNrZO5afLI5MAhy2c8wnMAGJx+O3PKUO
         cp8w==
X-Forwarded-Encrypted: i=1; AKwUvBxzf8S9l2WYEHzGQaPKjtMIXTA/5vMkbyEHKNceWUPkejqmW/tj7MH2qu0m9b+0TUcaSTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/o/gAASj85gSonHdTGkLjBYjM+UZcY7WplQ5NlzEMmXQkQ4ExU
	iQpYOkW1vjASj9nxGR8UXex0I9d1EvlMFnJ+ahXjgWLCqcMDzsvMVcqR
X-Gm-Gg: AYBFou1iUOKmVsbjkyXzl/uI8yUDm/hjocVk4Cb5cGszOp64DTWodVfuHgHGT/IjUvQ
	4eZxOU53dXTSlYcevlR+ys+bBPwkfzXV1OwrOildDMObLAkZcwyCm4V+YboT3nVhvMc4gW9M2q3
	0Gozyl1wSSpDaTu2skHgTkNJ7UVPj+SP56YGnIaxUMOJCE3DspZdw6DHqwysiotYV84qAz6nqgE
	cbXBg4RoN38T/GnlTGQMeagYTyznZzCHAF6Vl6N9lN8Lte2FyRTcYVIqs39QKdbx4/azoxqSg/H
	IWJEJT9g91N6sdeg0oLyK3Zn25AuqS3ot1a4LdU8Tn+LwERGleZSKX3KjfUIo4BNfBsnglp/LPV
	nriAbpmJAfOjWtretnpkn72G58Al3+L6hm8iyz5d4OpRWkOFGF4rtO0PXxCPYXpGnAw8iK47Ent
	p1mhcubvffa1QU4l9Xl2DkfWs5NtZ2B4IgxCuuZoM2c8jaDzoIK5LfzyqwjHr+TjS2pvCCaqmrt
	vzQZ5XH/UJ/2IeQRo9/Bo/KbmiDcQkF9if/C3MvlkvQS9jSVfqbGbtjXqwYGsSyAE14TXsyr0dQ
	TSNrpXh5gfzrodcb9vbC9MHq
X-Received: by 2002:a05:7022:158a:b0:185:869a:8c64 with SMTP id a92af1059eb24-1ac56ca0239mr24721522c88.1.1793773849198;
        Tue, 03 Nov 2026 22:30:49 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:30:48 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v2 0/2] nvme: fix removing namespaces under SRCU readers
Date: Wed, 04 Nov 2026 01:30:38 -0500
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAA7R6moC/3WNywrCMBBFf6XM2pEmwT5c+R/SRZqO7YBJJLFBK
 fl3Y8Gly3PgnrtBpMAU4VxtEChxZO8KyEMFZtFuJuSpMMhaNkLUEsd1RpcsYSDrE6GLGINZsVd
 Tp9uT7kcxQlk/At34tZevQ+GF49OH936UxNf+mupvMwkUSFL1dddOjdLmMlvN96PxFoac8wcuk
 0/JvgAAAA==
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

nvme_remove_namespaces() splices the namespace list with
list_splice_init_rcu() and synchronize_rcu(), but the list is read
under SRCU. A reader still on the last namespace can then walk onto the
on-stack list head, which KASAN reports as a stack-out-of-bounds read.

Patch 1 adds list_splice_init_srcu() for lists read under SRCU, and
patch 2 uses it in nvme. Both are needed for the fix.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Add list_splice_init_srcu() instead of open-coding the splice in nvme
- Put it in srcu.h, as rculist.h doesn't include srcu.h
- Update the numbers from a new run, median of 3 runs per boot

v1: https://lore.kernel.org/r/20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com

---
Qiliang Yuan (2):
      srcu: Add list_splice_init_srcu()
      nvme: wait for SRCU readers before splicing the namespace list

 drivers/nvme/host/core.c |  3 +--
 include/linux/srcu.h     | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 2 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-srcu-93d8a75a9b1b

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

