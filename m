Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876078;
	b=YpzCcj3iBrJPSQgkQvC35vvdpjIJPHYhEWAsofJpXcVgrPVoi4t+rH3HIAvIu5vqRMLT
	 qo4fBJml9UdPCD4mUilCUNr+MhjMeayEKbNTYSqJFeYsZW+2zA92O/dr/bdd+nfo8itWc
	 Z6v8WF0IBYWAasCHNDKlZAX1QAEAPDqYvrqSxpIHk42vq41lVVb1TMd9j47fAYVvr49Pl
	 gDD+x4VFTuIOP/Akx6eEgHGsx58ZDhEL3zC97R9SQev8gnh9+BcF7oAbFcbUQ/+dmicpO
	 o1+FACniq7xsBRb+Q8FSy0BL8sBh6EzWnnOb3SZ8G5wEra955LKQBoD36olGU1TzECA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hvp7TwQHCrNMIqm7jRQRWAQZXft95G4xN1Dkhbod8bI=;
	b=sRwO7p2NMCzOXMPyhOLKYHZW3SCxKoLdVGX9eRofg5+86xPRLsx33Dp72fyiGr7DbXAu
	 6sgDbL4Q7tSUGiiw2Os7JBAG6snLlLJwCl2K7hMK0oet2oHawZ7ColzIn/0G5oIX+RHf/
	 HRgXeRxvGHmtYTsgYUeItxkhE+X3jpkVRS9SckkhdYiDjJ7SYKx9i/qeavtTLwJA/1IOv
	 zjjPLPsOJVSpV4/N0swYrQYnsBok76m/eLmj6ApoiLAsy408vrECGZFoWbNL2kMTpJeTH
	 9D6FimRN0eUBKlA0cf6+LzGPk/CRi35HWJqjY/fVOOzDOM1EJtDU05SDgJnP54x2PPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzNflN9x;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4CA606A31C
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 14:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D4CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzNflN9x
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ba12b00c76so9309854a12.0
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876077; x=1796480877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hvp7TwQHCrNMIqm7jRQRWAQZXft95G4xN1Dkhbod8bI=;
        b=YzNflN9xxjMkoLx8oCHUhxYeI78BZR01+EJWRQTgigjHF74qZzkfQ0SXnWpiS9fZrw
         YqdfB/I8fWK9mT5xE/YM/HqYU5rbT7YYmyMiMRF4QruYkehor5yPq4C7ifDs3Qhpw9Hl
         0qtRB7Bd6hSM8Q3laHsVpzWEHp6SZoZyFntxTfQDAMQRhtIYxZiVT95QLNvMOdPihjIu
         ZjSOrrkuGLx7GUvzEFb01c3HIDEc+of5MixiWv6LzidPmC+U3RiVGF5NbI89IGaUsoiB
         sBWdNoMECXguXEuqvd6oDcCr8cKHvam+/pKigVhalTDW9OVPY75gn1PrpvIoEdj5N9RW
         VUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876077; x=1796480877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hvp7TwQHCrNMIqm7jRQRWAQZXft95G4xN1Dkhbod8bI=;
        b=ss4VGZa1RunqlLXdWcYq7IHzQTRwbwz6wjnzAkobUFn15hKXfF2pU5QpUzbXzyihAg
         8SgUIYLqhDH/D+U0i1G6S3T3mKpgOIOIUs+VBb/431TCfxK/5q9I4aofxFatv9+QrWvA
         P9SVR9lgefUKQR5mWoSl88RE/rQ+MZrRO27KjWVKCq6E1Jo1ZSLvIVZalzNseJ/aAVka
         zvdx05MxFFzwDfeCPtmPSD/9bWcACunE4BZyEpVTDfiDHcmPglQNUsvZdIsk7IKEwKRv
         9yBZ3Uo9F8qI/i6kuBK+e7b2AcfgeKRyww2wCKowQQOTVLHM+TdLxMNyVHvAYK3wsYZY
         nOFw==
X-Forwarded-Encrypted: i=1; AL+hErHBUp5/cH1Gvrhf9iIZZtrOdYcAqL2hrrRXoDmIlNAw6sVnlLfaDY92zXrkPZFAEAS2pDY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UHYCPEQua5YnAl/rd8ZC6tKajwNniy54ei6B7/+OKBCw5A5Nh
	fj5Fdj775OKPRq+aW5SvOjpomrKxFe5S1EVhATiRladWtw3modb8/xj3
X-Gm-Gg: AZFdTZe2P0gDYkLQ80FhnE2IFAmx1HFSE4XsFcHVsuOQX+d7pH6ThG0/8r9N80tULin
	oAOy5baejcS7BnBBi9p/9YNno3PBN1Zeu5m1zFBt7I2E/IC0sgraKStMFlvIaabznqdoEkwI3WW
	A4+Sjf0kmhF+LQTQixvV6EjnTi0OF54r7T7Gb0ojBzkBPDOpi3sV0OwoEWUoo40LO4Q8f/CauRG
	8MNWTRiR0uR3NZZ9SoMUJ3BUBGu10mz+WtCE4ouI16xn+/aSBAsj2Oc4Y/uCoUCZvchi/pfG6W7
	VlB+Eug5vOMe7mPADS7DmLbR0CLsvBG0iM/DxxqExxbettBrIB6L7psIJMvObIWyB37LAjtT6ay
	0rHfiqLnrBSVG10nRiHEeWHB5S0TPczqS5S+75a9k6nEzqUhL0nISWDBnfaMoGlhB8S41tT4AxV
	ReguxJfXqS/jAdu+ywkjlGZcupVu/BMbY8UHIAfh/rMWhf7Dg/vBAUV9c26cvWZtGhlErEWYY/K
	PeTTcFZTmkmUseaJFS+oHHuFuHZkvNCtmkM+6AJbm5IHIZzb2XHSMkoGyvW1On0+ec4lDBqKvj+
	uBXOvBlANYcuBrQ9wcjvjlpbXtiakR6j0stMxfVQ0hhD78VR4IzPdV1LLzMRx6Z6Np2QWPOsxSx
	04nPq1pFfj4IVPp3A
X-Received: by 2002:a05:6402:4416:b0:6ba:b24b:a25 with SMTP id 4fb4d7f45d1cf-6bab24b0fc3mr13921304a12.7.1795876076510;
        Sat, 28 Nov 2026 06:27:56 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm12448436a12.4.2026.11.28.06.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:27:56 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v3 3/7] rcutorture: Test duplicate call_rcu_tasks() callback enqueue
Date: Sat, 28 Nov 2026 22:27:25 +0800
Message-ID: <20261128142729.3756679-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128142729.3756679-1-kunwu.chan@gmail.com>
References: <20261128142729.3756679-1-kunwu.chan@gmail.com>
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

Enable the existing duplicate-callback test for RCU Tasks by
setting ->debug_objects.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 kernel/rcu/rcutorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1648e6369d809..8c264aaf1727a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1327,6 +1327,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.get_gp_data	= rcu_tasks_get_gp_data,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
+	.debug_objects	= 1,
 	.name		= "tasks"
 };
 
-- 
2.43.0

