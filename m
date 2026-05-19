Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380143B95EB
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219935; cv=none; b=ZZQ59thlbyV7tQoeYJnRtl7WhJajn1rQvtiM0GDemCLLh0dbsUH+Xpe1iRweO2QsA2vRRHeu9sVNFB0ughQAxY3mUMQ8aiRCik7EQx7Ro4CSlghvjXgShWDivoEevwXq5YUKZGCIRMSExnzxqz/zNOKIqziePlTyxb359Pn+S5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219935; c=relaxed/simple;
	bh=RkHk7z2ygyoyi1ilNEZkRX+Ty9Jdxo0cKjCdLWv4d/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYUdZySIyhnLJ+swBAWfKyWti9ECQWsKLJS6EPV3zrMJxHxioFLoGrdNuvgVVLyliGW6A2ui5hOXV7cInx9DHAftX2TwgSLGTYMr+cupL+Ln7wckZap1noB4yO6ly1L2x6CPhYnikwzGar+Lb7N8Td42g9elD49insnqYgSXyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oo/cVKbO; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oo/cVKbO"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-392445f11c5so44288051fa.1
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219931; x=1779824731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfDpEv+39iIZARqiCjGlpklYp+nlJJtKSY6Ud1S1ntc=;
        b=oo/cVKbOwuQ9VzCH0JHE1tU30g9CZHYXv/oAQzJOAFFxCanZ0Rj6BrHDbzGkGWNQtl
         pzqK3l1Y2WOc7adhC/LJ0xGeVUnEa/Fq4XEwS1YcnKaUIssBN8J/IVZB5vPPzHBdetbX
         mOrwQ7sxRinxJ4j4cm2/MmPnKDq5byeQ5k1CsyDXIzeuPiheMeQR0y71uUsQ1UYElB80
         jjZESSdhZTNv6nfD9NnadsUVPdpSXbSuBKgCytmXqvLXD9h39AsEd8XkEWGNiyoGaVrB
         sfaS4gdpNu7iZQeDswTSXS1lu2jxHiOxwnWJ+JULpJbmtrnlsVzsO8w5oRWRZ+NDpK0W
         yFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219931; x=1779824731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HfDpEv+39iIZARqiCjGlpklYp+nlJJtKSY6Ud1S1ntc=;
        b=EwGmtZTb9rQ35sc4rJQEh3d5gmqbAiwmd/KSPKfLOANn/WYukwV9FbOP2FhvWTjf3z
         PXigiWHlMbMJIuYnQgJ7QhsUvG0zGQ4vzg2BWxMx7K3QzArQiYhLyBJNBEMk0j8djYq2
         jr6xhewHJqxGou5LNt1ugMs6unuMOh5YgWetbTStjgQCCRV7HQrYbCBZyc4l6PtackYU
         vk/09OvwM4/9bkmj4j9KkRIR53mx8R1RhP8xio1+yHg6vqwgCFuFV4yhGg/vpjCktb/n
         zBu5pClXZ8YMJTie17qY6MOeErTnI9Z9IpGN48f/blkzRv3yznaBMjuScCrMeIxCOL5e
         +03w==
X-Gm-Message-State: AOJu0YwzCYUWXGH7ECtnl+2GrqBTbsWp/gGD4MUBxxMsdXaF5zudPq/w
	jW75BRSNoDPGbdcWNtdTeezE34MKWPxkHjXtDcxRO0RO1wM3kAHD++uy
X-Gm-Gg: Acq92OEmBFIMaYx0L0Ym3Rdw+CB4W5SryyTKSnF4beBWnxx9RnIqj+T+p+ffNjFlQq+
	TWyD44TIt3c+sjo4iNkkki2f4V3ztC/IvsdlZsJHjQV9f0nRYtLUli2qAkiNPbEe0VW/hpUGWSx
	9Q65Xr5VS6EbMnkWJYonNBD8r9m13Ztdajp6nP1GXqIoU9vUsZXR6KX19QVwdxJNE+jj8bOGJ44
	BUzvGm6YOykPD56mqS01S2ODLDpTqrqTaoIXP3lK6uQDZs14eXodXQZ+z19Ch+uryrNJI0w6X4a
	WunefvSYINWYa/C0DK7zk6x2BBm3gcYpNA46uau6XWuUVCjqpR+1HkyARkpo5EhYqu9jPk5uUNv
	fqwqBzUf9R3o4UyWGWMl6A2a0X0Q+uR+R03m7SB6CCZ+fH2dT8hQM0A6Hs248k5CAhq6FSv6w1f
	JlpLEOWCZqpBjogPc=
X-Received: by 2002:a2e:bccb:0:b0:393:7f7a:4047 with SMTP id 38308e7fff4ca-3945b60917amr73751851fa.16.1779219931313;
        Tue, 19 May 2026 12:45:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:31 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Maxim Mikityanskiy <maximmi@nvidia.com>
Subject: [PATCH -next v2 09/11] rcu: Document rcu_access_pointer() feeding into cmpxchg()
Date: Tue, 19 May 2026 21:45:22 +0200
Message-ID: <20260519194524.158515-10-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519194524.158515-1-urezki@gmail.com>
References: <20260519194524.158515-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit documents the rcu_access_pointer() use case for fetching the
old value of an RCU-protected pointer within a lockless updater for use
by an atomic cmpxchg() operation.

Reported-by: Maxim Mikityanskiy <maximmi@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcupdate.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bfa765132de8..5e95acc33989 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -592,11 +592,13 @@ context_unsafe(							      \
  * lockdep checks for being in an RCU read-side critical section.  This is
  * useful when the value of this pointer is accessed, but the pointer is
  * not dereferenced, for example, when testing an RCU-protected pointer
- * against NULL.  Although rcu_access_pointer() may also be used in cases
- * where update-side locks prevent the value of the pointer from changing,
- * you should instead use rcu_dereference_protected() for this use case.
- * Within an RCU read-side critical section, there is little reason to
- * use rcu_access_pointer().
+ * against NULL.  Within an RCU read-side critical section, there is little
+ * reason to use rcu_access_pointer().  Although rcu_access_pointer() may
+ * also be used in cases where update-side locks prevent the value of the
+ * pointer from changing, you should instead use rcu_dereference_protected()
+ * for this use case.  It is also permissible to use rcu_access_pointer()
+ * within lockless updaters to obtain the old value for an atomic operation,
+ * for example, for cmpxchg().
  *
  * It is usually best to test the rcu_access_pointer() return value
  * directly in order to avoid accidental dereferences being introduced
-- 
2.47.3

