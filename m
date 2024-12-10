Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC061D5171;
	Tue, 10 Dec 2024 16:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848842; cv=none; b=UPEMvYmsKBuwEDAiaNMPdhca/nhBpYteZJypJ5dHACwZ7g3AyA3ZTS1Km2IdWmFGMp7yBxvdwnjLPnCEcnEkrBKLvxI4N6cxbyn/K4HIzUuKtsB/DTeUNe3QIIEp+grJlBgtv8vGDghrv3kNrTt0xC0Q41UIolPuQJx6k7b8Uj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848842; c=relaxed/simple;
	bh=Urh+WmY3GFT00nqYOZ92UBETC1FBOevOJk0kXUGPxaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WXKL+qPuOW1kpEGFVas1py3c2ElUotcSbDcFpToNtg/gQCjOIMpo4yuJ7atG5PwzHHrLdpImg5EKz8dQ1wZwYUPrsiAkt/np9AR1iQrvMnqs0AWszy/0fl5EpfUaELRygr+fYC7XFxJwfLiny/dZCAF3fc3pFE6XZ+U9L82jnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlNH9x96; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlNH9x96"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54021daa6cbso1951566e87.0;
        Tue, 10 Dec 2024 08:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733848839; x=1734453639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdPE5CaBHMhT6cavsDrFmlg9kwPywztBv9Mfz0gYFxI=;
        b=IlNH9x96sjb4g+9ESbXCJjr21rfg4/nXliJ072RuqkYn36sDUjt0d2k2LLPRfVCzY1
         MFXaBvN7T/dmv76lnfuU9VYBZbsqHQ+L3mA/ZO9TDgEGDZEiY8Vxix2zQtK5C7T0d5eM
         odwi8z1ykLUnUZgvh2FRnXs8XgNGP877K80kB3RVMUm41dTOH0yao+40sMl6xe2t2V25
         P4sKzDONRc6ePQ0Ro2qup8MKrzfH85l9hejS/xyvbAZqHDwBc2oF7RslhUd+dWVBFHUk
         KI5kYRg20lECWx1muQ0UFFlLk58zrlpCD9X6oozWwhQVJgeILX9SmbYcwzV6XqtV7Qpx
         /75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848839; x=1734453639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdPE5CaBHMhT6cavsDrFmlg9kwPywztBv9Mfz0gYFxI=;
        b=oS0CButkkTXbV/nW0XREZDhCOTPi6ddNLgsFzBNCU/qxPDFsaK+F7J3egwwl7uFk4/
         n3GSdmItxQRlpwpLe99lPnEK60P5Mq5nCJwsKdtKXumJiwy6H/NrenHLVUO4/f+8eWV2
         ElPb1FGe0x/as/nljsaEGAO1ZEEE/aln+JPP7Lnzg4NgXYp1ryTgZFVOw0IIvO0njutf
         Tun6edr+6Qy1dG0typpD99qUZmJNxiUhVnGDT1QAi9/R4oiIe1OfLqcbd6sEwLbcnLlE
         uKZeim/ct7F4umEkmlvqvvsNNrIAVULiiKhuyNop7S553qkujR8aIvndWtr99xmLwNbX
         1ycA==
X-Forwarded-Encrypted: i=1; AJvYcCW23tDoAM2JVFOE4+yu9Jz6hPbG68CON3ZwrafsdZZ0QsT7XO4oJd92pMJ5M9KKHxJvXIhD0CD7czUoBpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7K4wYC0JwYi9G5a4sWPOViMLywKt2SVTTHUGK5179MtniSHMW
	V+X7mtz5DUpJe4Af/k0H8Sa6NPyH2JsQJ5/B239qz2VIun7cdwu2
X-Gm-Gg: ASbGncs6MhS3ECf66QQVA4dPqTFtSp3iFV7mnI+JohTzLNQmZA+kECxUARIAPKVFaPs
	rzRaZbKze7g7NCSvOFUn4hDTD/1Krw6KRPG/55RBkDPzseHtPOqTjrymlOUivoGA5ivDDZlvf1j
	VCQaMEZFDyEs23AmCGffatVXsMXwysbyeyj2CSXxgRX6UV5bp1N3p5IOubGzhwt8OeeM4UxicVW
	n5ifhqIpx41yavUCRutsdi6peFofAH1N7TkH8zVUOW6IXe2lg==
X-Google-Smtp-Source: AGHT+IFXg03XavY3zbgVuUO+42mxcr0qW2R92VYVB7iUi/Qw3cgWDDrElu+xTCGcLsSdSOB6pE9uDg==
X-Received: by 2002:a05:6512:15a2:b0:540:1abe:d6d2 with SMTP id 2adb3069b0e04-54024107498mr1918094e87.35.1733848838529;
        Tue, 10 Dec 2024 08:40:38 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f93377eefsm1031875e87.67.2024.12.10.08.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:40:37 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [RFC v1 1/5] rcu/kvfree: Temporary reclaim over call_rcu()
Date: Tue, 10 Dec 2024 17:40:31 +0100
Message-Id: <20241210164035.3391747-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210164035.3391747-1-urezki@gmail.com>
References: <20241210164035.3391747-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to start a smooth process of moving a main functionality
to the SLAB. Therefore this patch:

- adds a support(temporary) to reclaim freed objects over call_rcu();
- disconnects a main functionality of kvfree_rcu() API by using call_rcu();
- directly reclaims an object for a single-argument variant;
- adds an rcu_barrier() call to the kvfree_rcu_barrier().

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b1f883fcd918..ab24229dfa73 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2559,13 +2559,19 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		debug_rcu_head_unqueue(rhp);
 
 		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_callback(rcu_state.name, rhp);
 
 		f = rhp->func;
-		debug_rcu_head_callback(rhp);
-		WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
-		f(rhp);
 
+		/* This is temporary, it will be removed when migration is over. */
+		if (__is_kvfree_rcu_offset((unsigned long) f)) {
+			trace_rcu_invoke_kvfree_callback("", rhp, (unsigned long) f);
+			kvfree((void *) rhp - (unsigned long) f);
+		} else {
+			trace_rcu_invoke_callback(rcu_state.name, rhp);
+			debug_rcu_head_callback(rhp);
+			WRITE_ONCE(rhp->func, (rcu_callback_t)0L);
+			f(rhp);
+		}
 		rcu_lock_release(&rcu_callback_map);
 
 		/*
@@ -3787,6 +3793,16 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	struct kfree_rcu_cpu *krcp;
 	bool success;
 
+	if (head) {
+		call_rcu(head, (rcu_callback_t) ((void *) head - ptr));
+	} else {
+		synchronize_rcu();
+		kvfree(ptr);
+	}
+
+	/* Disconnect the rest. */
+	return;
+
 	/*
 	 * Please note there is a limitation for the head-less
 	 * variant, that is why there is a clear rule for such
@@ -3871,6 +3887,9 @@ void kvfree_rcu_barrier(void)
 	bool queued;
 	int i, cpu;
 
+	/* Temporary. */
+	rcu_barrier();
+
 	/*
 	 * Firstly we detach objects and queue them over an RCU-batch
 	 * for all CPUs. Finally queued works are flushed for each CPU.
-- 
2.39.5

