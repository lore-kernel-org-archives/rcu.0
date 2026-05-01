Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0251D6DA9
	for <rcu@vger.kernel.org>; Fri,  1 May 2026 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641393; cv=none; b=JpwiOmCaOdblmRXmyQxVSUCW4QYFfet9dEEj0rOmLHffyQR2XY3MmeKL2lR0feO6dhWLqbzk2j/9wfOcnZBJqZJqgWpGAIZ9vkt6oP+uzXXKNZntmCSGeiFV+GOJ9BQqmjUx9GqagdJbT4Wf6xJTm6/qkjwEKvhi6V0Xdac+LRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641393; c=relaxed/simple;
	bh=sTDR12sjqTwMm+r4fFdhIkquUwcGi7MUb8j8uCRfvQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=segNJvvtpRDWlBhy7ud8Ltb34bhd+Rtm5uB83ya4OsPnMu9HsQoI+wiG9PI8TJGEWMsBwRPLTPB8SscXbCDvP8+skXmag7RNoH0wTZW5d1KGr7v0luVhXwqIHcVGLossOTd8V6adIBlfcOAtqiT7HhSLr7L4hvWqLofAfSjHcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FngKzejZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FngKzejZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b2503753efso19255335ad.0
        for <rcu@vger.kernel.org>; Fri, 01 May 2026 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777641392; x=1778246192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSUUEhTxPVnTNICfoGoDgRMvs6IfWcbouR7fQZ1ACRQ=;
        b=FngKzejZI6r7wA5Ta5sKG+y4Bw19tVRdMRnacCCstkDBIZYK2I6O6fg9xg0sXJdUMy
         i80kkDq9uFc0UwstRGN362v+co2ljGpz7kyiCe9ZD3ITw4mz49E0NCX60CJ2tNCVtsiw
         UUB2v40jc38RCbcsbiSWM851Jep4UCFRgQ2Fko0yUXWOOgzzZEWDPMekYL0ReQ0rTGnb
         vieLLSjxi8sYDPEXyp+h8j0eq8Pq74D9thTj8zVdTWoNKMX9JYv5YApiUEVC11P166jF
         fTXnaqUhIusO6L6DvremxbDX255CVGP+SILcSGgTl3zXRenzlCUmaG4YMbso924pPe0u
         xDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777641392; x=1778246192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSUUEhTxPVnTNICfoGoDgRMvs6IfWcbouR7fQZ1ACRQ=;
        b=QRFNf5zp1BdnoG8zI3DqjKq6/TOPx00SoiMEoUSSYYhorUGjiKPePtCxofInq+/sHq
         fUbnjo15/44BwDC2+asXayQDivHSxlz96aj/ujaWcC0t9pxD4hhfcSnjo56cWB04e0y/
         I2ZN+XqGnAI6Jm2S5dU8dhYdCdylLjCDGXXWQtay/hZKbq4QlGHIwZy9CIPwCR88tMtX
         zr56m3WoOZKIuA+cW8C4lROHeRzIoZO7Xoc0WxIc11+jYdniIgYJjfwc9MOQNx4moD4u
         EeFOm8p9C09hFlZVXb27B9VAEIc2htJHz53YyBLy9MNtO5LcnZve4iHL/k07bqMOY7pZ
         7rVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8RwvjO8FjM59wCHwK6y10ORdoxLHrplpwak4n8e5//BMqVWqZ4QUPCecUtt3cwidWSic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmgBb9wWfDOwBQAfyZbnG5tGE8ul0H6C3g+oW9LZqh6V/wAcne
	Ge5+5k9N9EfevozmAJ7LvpQKgxo2iBRKOpEWmHwJYwq6QmSx2oh24Ypm
X-Gm-Gg: AeBDievJaFQQHL8sHWr0+qFuaDVmiPqGJ7OPI5YABg31OYVNbS9DZm/bHydlviRyJBM
	9lQGVkNokeDDqgYHLhE/YsKoz7fli6JWFoyjP6IKrveNyg5+kw8mN8587gKf6MoYmKo1LPM8cmZ
	e4b1swEQoyKBtUcMIPxWdW7ZczeXmpEkkevXk2RxDl3LF6AnlA5rr4yuR5O1uVhgTh17348oJn+
	l3zEKg8VQyVgAxjIHLAWaAGcYZgsnbWvBaOuxPW1sZq7cC52DaMfaFb4DM3Ky4BuK2DlsM2AJBX
	r6GVMHbVxhPzJrir8LSZ3NXTn57hmsLTg34wOaleIlL6n5jLKCjaVWPivZowd8va+KHwJ2HLFVR
	g+2I3GfcfZ1U/GYiyMU5+D08XpTreaLMa1YM1BUp4It6YgE7aQQrIZbhOt9FH43l6u5IiMoLSK8
	SzPHOybjCfU4OHElvUakrJEWHtz8lYUv7S+67yh01SzIe70qVuEbkFP8UOaBLf5pI=
X-Received: by 2002:a17:902:db0e:b0:2b4:5cea:f618 with SMTP id d9443c01a7336-2b9d36d7eb8mr34519585ad.3.1777641391704;
        Fri, 01 May 2026 06:16:31 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:57df:16f5:b7ab:5d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae59f62sm22438005ad.70.2026.05.01.06.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:16:31 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH 1/2] sched_ext: Normalize exit dump header to "on CPU N"
Date: Fri,  1 May 2026 21:14:56 +0800
Message-ID: <20260501131521.161852-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260501131521.161852-1-yphbchou0911@gmail.com>
References: <20260501131521.161852-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify to uppercase to match the UEI output.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 45a2668284bc..48c65ac8e230 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6486,7 +6486,7 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
 		dump_line(&s, "Debug dump triggered by %s", ei->reason);
 	} else {
 		if (ei->exit_cpu >= 0)
-			dump_line(&s, "%s[%d] triggered exit kind %d on cpu %d:",
+			dump_line(&s, "%s[%d] triggered exit kind %d on CPU %d:",
 				  current->comm, current->pid, ei->kind,
 				  ei->exit_cpu);
 		else
-- 
2.48.1

