Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795741296;
	b=vLYHylvHBWKhUbTN5BhpbWWMf3Hl/bIhRTTWpDKI20zjV+TLB5e5oaGNgrs3Fvklj//X
	 8HBwrxdq8WprFLpfk7awpuE+XaxmyyVr3sYAIi7GnJSFb7RIlkG7CkUVZDgkYYwwhanzw
	 gz2ZOuYo08JAxnV+LaoxTYHWaJaY39WQfKjc75iqj+TBRI00BoWgZ0sKD/cv4+Dj+cLdk
	 /vi50uR7koXLBl3v293SrTpCFadiHacbKDnSEo6GfF4zOXQz0ziHASRFpKA35/uWuVB9X
	 5tycksh/tZSzAktxJAnPcMex8xQiL5HK1i9gEqBARnO7GpncD24qr2N8iIHsZL0HtXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795741296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
	b=kiHw3JOULmwnjlIkibxSiqZjsTMsA70uFD3b/5om+L+10/B3kJpFkDZsOLZWMtgOs3EK
	 ke+loFKHDetzmY60NE5VVFMlaNF7O/GclsiRJrU0owRRMGUTPI041O28jYwXosCaO9pL3
	 Lynv9d+ayvTuFNCdVcHnvsyArtV6ZMOEAFiBQTaehCMPr/A+alv0IdCc/wzZR3LC2AalC
	 Qou7DCtcwICNbqVlIxMhoJsRr9qvEPcQtOy+bBEtikc8zHcjn8oPQNJOV799rkWDzoqdV
	 nbZdfZWM8C7pi5gVrnjKK4/vF6z7zStbR5ucTK6ASsOhlj+aSUbcDR1QjKkvqO6nX0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2jLSq1T;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E9606A31C
	for <rcu@vger.kernel.org>; Fri, 27 Nov 2026 01:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A42E9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L2jLSq1T
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f05b465cd1so41152965ad.3
        for <rcu@vger.kernel.org>; Thu, 26 Nov 2026 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795741295; x=1796346095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
        b=L2jLSq1TsxTtGGugUno1bN6CZSx/7lGwp9t4+byNhC2tfSo4NBQStXHUoDWQrgSsXK
         uLfAS+ATmhVr0h7eyhj7uyTsQ7zGPYRb376ggq0TtInys+4qVsX+GcePm+k8SyHQLF24
         4bhHyNZ07NV2QW45M6Q44P8PMxK15U6PHr8Rd+pEhbvezL+D13VNezc/2443eNafyO0g
         3On26BchelSQ0o5UjZDHRkuJOYdao0r81FQr7ivRu/uEni1Ku2f+SLZczCRc58Xm8kyd
         cCzszz38A1ROnM76ziRueYmGuOpCEJnazMRTDEdXp6TA/gxWdnGbcjO2SRB/CZPQZxSA
         PRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795741295; x=1796346095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R2dYx+9VfkblowgRJ/VmPm34jz2gVpt82fxbuv77UBc=;
        b=X3ym8hgVjJQEwbk+0bNAb/sQVUQNRPXep+Wbjscy6Hyj3tCGE0l5JYMqNSBNmh0dNE
         P/3IevHAiWDZGi9LSPvDmR8kLtWIdGHjmG6Av9byIisGyaXRlIG+rrPfIQubSevMN/fm
         6It4ghcI4GLULLZqzNdfSc3YVASoJTBLqsfQgj4LJg1Thtppv5FEXKRjZNtuXEX+k7lk
         WP1q8bLQNB5CiDrb0TIMcVm8u832vymNPpXe4ZKYyA0T9dvU+arLejzBzYyvSpxI+Cry
         SFV/FyNJHaVTM3lQHYigZkrDNboqjusKfubebrl2ps2zacdN52r6ySHx1eFhJsVWuyrc
         6sYg==
X-Forwarded-Encrypted: i=1; AL+hErH06NfOHeHR0P7/wFt8PRj+oYXspYhtN4suREZ91nEqaQR9hHKWY4J7xz70h1soMm58bP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DQoOJf/WaU6T9gWEHXQ2PIloa6CUecFexW4CW+nF9/fjDy+fF
	2EgJRxxn/ToTt97tsh7lXIQAMyD305phJkfQ+S7nqgX6fENwN+TIbST8
X-Gm-Gg: AZFdTZecRDjwF8ZscMFwE9cDpVetYnLnT5aBsYt7eyZqoqF94pHffavxt3chjvHfZZg
	Uacsf39LdeeFbO0ZVwx+ZytFpe5Zw/P6lDfTEdZRsuZtljKhRXliVd+VSpc4ZdP8OkTluecundB
	L0dy1GM+a/+XfX5iPlziTT5vUnklMMOaDjefh1TcJYXXAYpDhDoDeHjasoqLz0oXqtGvcvQigZr
	PBjnzSweUGye+GTLJwwTSlgUVDsL//PKJFgj93FLyQ8h5rZ5Ur7BQeymGpMiSYsWIStF0+sS9qF
	76o5eI9/LNWuWOZqzjNH27tfh1SNNx466ck80rk1Hhrl2Y/yQBvpPyF7YiDy299qCpT1KBimtWq
	oNaO488McK0U+vl6h19jSminhpvJAtpX66EGwtwH2Sfr2P6iiwvRL8LWATeC6+4U9HNqEfBTL4x
	yH32QQJCfzW9YZPazRV6uWSW/BBpVs46TxeFsy/ZRO2JTQrvselD1CIZhkDffJPZtA7ex+wMr21
	Nuq+WT9gS4M7mcjQ8Ji9QYexu6tzet+Zidzgh0EpjeBaWHB5rbrxty6ML1IM0jDm74RNzV4Y2ya
	i72bnP0uOewBPXJ0clMtWp8xpDYlGgQcSMFfNZ293vBpJtCk/H94Hsk9xDUZk1fkmF1CLuyjXV0
	z
X-Received: by 2002:a17:903:230d:b0:2ef:f432:3fab with SMTP id d9443c01a7336-2f03f169933mr212665565ad.43.1795741294670;
        Thu, 26 Nov 2026 17:01:34 -0800 (PST)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f051a566f7sm99260055ad.41.2026.11.26.17.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:01:33 -0800 (PST)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: jarkko@kernel.org,
	peterhuewe@gmx.de
Cc: lance@osuosl.org,
	rcu@vger.kernel.org,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linuxppc-dev@lists.ozlabs.org,
	linux-integrity@vger.kernel.org,
	Li Jun <lijun01@kylinos.cn>
Subject: [PATCH] tpm: ibmvtpm: Fix unused suspend callback with CONFIG_PM_SLEEP=n
Date: Fri, 27 Nov 2026 01:01:24 +0000
Message-Id: <20261127010124.848125-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Discovered in the Open Source Lab of Oregon State University when running
RCU torture.sh on a ppc64le VM.

With CONFIG_TCG_IBMVTPM=y and CONFIG_PM_SLEEP disabled, SIMPLE_DEV_PM_OPS()
omits the references to the system sleep callbacks. This leaves
tpm_ibmvtpm_suspend() unused and produces the following warning:

  warning: 'tpm_ibmvtpm_suspend' defined but not used [-Wunused-function]

Use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() so that the compiler
sees the callback references and can discard the unused PM code when
system sleep is disabled. Preserve tpm_ibmvtpm_resume(), which is also
called directly from tpm_ibmvtpm_send().

Tested on PPC VM of the Open Source Lab
of Oregon State University.

Fixes: fc0ddb3174b0 ("char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management")

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 51c7e2add3d2..9840d0ebe6a3 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -462,7 +462,8 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
 
-static SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops, tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(tpm_ibmvtpm_pm_ops,
+				tpm_ibmvtpm_suspend, tpm_ibmvtpm_resume);
 
 /**
  * ibmvtpm_crq_get_next - Get next responded crq
@@ -714,7 +715,7 @@ static struct vio_driver ibmvtpm_driver = {
 	.remove		 = tpm_ibmvtpm_remove,
 	.get_desired_dma = tpm_ibmvtpm_get_desired_dma,
 	.name		 = tpm_ibmvtpm_driver_name,
-	.pm		 = &tpm_ibmvtpm_pm_ops,
+	.pm		 = pm_sleep_ptr(&tpm_ibmvtpm_pm_ops),
 };
 
 /**

base-commit: 5f22fb20497f4983094131f00a734362300d22d2
