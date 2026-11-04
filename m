Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773854;
	b=Rr8REjy7DQ5naFbvc8fQsR+o/+megPuWplW137O7IjdGZbYAqvlPDVzagYR0boUylAaL
	 n4jjokfYjbcQ067dDzSRp83+0VuO6WWP3BZHkcF8f9knPPNyHnHbWVTIa3vx4ImgDoeGf
	 h6A+Tl5u5X18VgBuA+rVxM4KLYPIB8TDnWoIZlSC4nB4ZeJK2s+C4HpTJygk3by6Arupo
	 aJKJ4IlMtzNUkww8KyRA8p3sFNkZ4ROeJxRFfp7TrslRjc1lLfDtyvlTpqXMnInhM5aNR
	 QAMG3ZI7Ra92WddE0gdNx+XCSCFJ7SDTcY5crqVCZz2Y9ETVYjtGqhYqDeIh52b6jvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=;
	b=DpdQ/WdekeTvFMaCy3iMPz9wKcbhVOKt6962yrMt195fnfA25vBfDlwgHVSnBEx+HzGZ
	 mBJhgdbvntqL+JCkg5/ikybmMcyVS9Cx6tI5SmFx3kLwacAuhF+FQaYiuZf5Ust6M1Hpo
	 Scf56FVr8ChX1evcJqrKfSW5Maf/wbIHyhF9NaevKUXCX03xu5xMsjIRHsPIsVlnfNHwJ
	 xyo9RW8pTWNHiZPdokV+LpH2yhgskSR/MgL65lrZ3gtuuqtsGtARVMIZABPRG79hVM8Yo
	 IgzADamAdQmsJdezE6PCr2vSzXgXygpfYvRCKAYsIxDkcOh8HfkdQWTia9C9FTAlbDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ghm/XOD6";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78298606A326
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 06:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78298606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ghm/XOD6
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b1ce85287aso363061c88.0
        for <rcu@vger.kernel.org>; Tue, 03 Nov 2026 22:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793773854; x=1794378654; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=;
        b=ghm/XOD6ujPLQihO+KHWRj6ldK8L1dBP5jTWwWS6woQhENxcApbdzhvp1Wj6v4P8om
         ITut3zVMqYf/Scsl8DFAlm69c9PrwbbrUfBS5OagQizpIzR9yFWKyMlSdd3aoe3msPVf
         hmX/FVpWr+9H+R7ID7LcY+QjG7UHL1+M3H5joLlYmjXp+lZRoghzdOFCZjlRkGxpQv6z
         saaKmnrLcxovWeHTUb6OnyZwmto7wFJKnuBGOaDPjz0sXXdzKkrmva+p7P9oEkWN515R
         ueiPfoGB7EKHqm+o5VE6ROTzqx8YJZRdeEZXLOceE+wjcVc5TIwUbgimyZGfjTwGzysq
         8O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773854; x=1794378654;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nxObPTj/uIUEGHfeQ9adXhEvppId2c7V0+NPSeSoNZI=;
        b=0afr5ybOqrczbkuBaSKEXoymlUga882gRZ33JjfH1v4K8rRVIgsZjRHCl1nZIfmfmd
         GUvGPlZzVpwu5kzai12qgs8bdJ57lhieKPNqRLm0nwM5Wnx2cX0g3yLHYQobme7h84Dp
         DpZsZPQLelmBGqDjGAGQOL1oB2vjMIouRDls5lb/SXBBIowfQGZwSc1pluHg9466RaFs
         LpRpgQlGVqdq8LHImxWyTqm66rvkptf4ZGbrs3YOBBwxQ9j4X6d5ywb0YHXr4jVyLLYO
         EddVNFH0X2Gzd5rns//TMcbMfpbCuDfN/zNehE9Idsz7ZJlWVqx8MyQKisbvfQ6E00MT
         lpvA==
X-Forwarded-Encrypted: i=1; AKwUvBxirBilUYZmWz0rFumTRGviWhTdY5GsYVzqmv+Bpal2z10DbMpQTzrE5Vd02kKzrNdgHRw=@vger.kernel.org
X-Gm-Message-State: APuU4Z92ESRKaOldqeyw3TDMK4M6JH3Pj/Td/70L4PCiRr5jzdMhgRRw
	G5r0rKedoNcAtn5JgdR3itFz3F+VqQbu/K2RA8i+hr+DtIgkFHFKiL8ld+mOHQlxXe4XpA==
X-Gm-Gg: AYBFou1w0svy3xXIzk3QWMvClQvj+RVa6kDTreF3/GGITXYJt1+QUaaiTjjCG9F6kHb
	BstaFJsOiOzmb1a8WaJrQwn3lcSLxJRH7ipmjXRWmPP/k3IfsE/jwI3KFqPVsLub9ycWUXH1L1k
	9ROkycFWT/7dpQ3F7fc3J8xQnnN4ZE3JpODYLm/cKrTDKspYLdj4hdgY3GZkI9t6ei3PNQyYSSb
	ku27uUPu6Z3lj1tm3dR5qSXr5rZrQekf0/f/1V/6IYulZN5hz74r/qaY6alHH4362ZNaxrwZrGq
	vjZJVamKEGHztgn8Z/zZgEggfoipJ3UWmLjacg5q8d+DkT/XPqpUpW81lOvPDEAUKGTkmuRJdAx
	XFLXrx9zHIA3p9kFNInbOv6HPP4Ir1ghmIXExQ49hod2fhClAH4Pfi3EXOmNvenFq6MJPi9Q796
	r0X4kFXtYQdUVXwu8b/PIhw9Gj52NlaNbGNPnNacMFn6shjJCE5Gm7ibCSU9Ma71+Z5O5Gi80vy
	FxOjb/2lE8L/46rRGLRJtJ5v7RPRBTWTygXiQVp1kcKMHmazw5B/gQH0bfz7u1zk2kqXwkr1YOq
	w5VBRmQfZ311tD71Jlhtu21Y
X-Received: by 2002:a05:701b:455a:10b0:1b2:42ae:94fb with SMTP id a92af1059eb24-1b242ae963dmr4316991c88.37.1793773853561;
        Tue, 03 Nov 2026 22:30:53 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c65194sm4454290c88.19.2026.11.03.22.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 22:30:53 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 04 Nov 2026 01:30:39 -0500
Subject: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
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
Message-Id: <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com>
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

list_splice_init_rcu() makes a list look empty to new readers, waits for
the current ones with the given sync function, and only then links the
entries into the new list. The sync function takes no argument, so it
can wait for RCU readers but not for the readers of an srcu_struct.

Passing synchronize_rcu() for a list read under SRCU still builds, but
leaves SRCU readers on the entries while the last one's next pointer is
moved onto the new list head. nvme_remove_namespaces() does this today.

Add list_splice_init_srcu(), which waits for the readers of the given
srcu_struct instead.

Cc: stable@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 1a8a465a5650d..d4dcaeb83e2b6 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -18,6 +18,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/rculist.h>
 #include <linux/workqueue.h>
 #include <linux/rcu_segcblist.h>
 
@@ -118,6 +119,41 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
 void synchronize_srcu_atomic(struct srcu_struct *ssp);
 
+/**
+ * list_splice_init_srcu - splice an SRCU-protected list into an existing list
+ * @list:	the SRCU-protected list to splice
+ * @head:	the place in the existing list to splice the first list into
+ * @ssp:	the srcu_struct that readers of @list use
+ *
+ * Like list_splice_init_rcu(), but wait for the SRCU readers of @list
+ * instead of RCU ones, so that none of them can follow a next pointer
+ * onto @head.
+ *
+ * Note that this function blocks, and that the caller must prevent any
+ * other updates to @list.
+ */
+static inline void list_splice_init_srcu(struct list_head *list,
+					 struct list_head *head,
+					 struct srcu_struct *ssp)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *next = head->next;
+
+	if (list_empty(list))
+		return;
+
+	INIT_LIST_HEAD_RCU(list);
+	synchronize_srcu(ssp);
+	ASSERT_EXCLUSIVE_ACCESS(*first);
+	ASSERT_EXCLUSIVE_ACCESS(*last);
+
+	last->next = next;
+	rcu_assign_pointer(list_next_rcu(head), first);
+	first->prev = head;
+	next->prev = last;
+}
+
 #define SRCU_GET_STATE_COMPLETED 0x1
 
 /**

-- 
2.43.0

