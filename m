Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135BC8EB;
	Tue, 18 Feb 2025 00:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839882; cv=none; b=V1FdW7wCwOGh2zxuOcAKKWLZANBks2/T29woi0TadyPb4bJS9f6MI0jLdFNWi6p9THp7Pd1pAiILMWgZhOmf+CBzrp/2WA4ED6uCoRLuGfyuGfxHFQHju1dEjjErE+8FHu9rWjpTQgiMqobmpajs34D3/99R+OLvpzJyRrUnYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839882; c=relaxed/simple;
	bh=O6Yk2/OQfzp/7Dw/mmNhy/Ct1kWW17flOJOd36ykW4M=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BAL+Gl/zIBTkPw/JNGrMDJfQ/Z1IdE+R/xFwEPazWXGGVNOa+2fSUDZ7QD5QURJpNCWrJxQAK9lbR4yjIOcS/WVxEs75gJIiY4r8eFRrKY02K6S8j5+DG58e7m5tQsPf7fJNcc79JKIk+7WDWVaAfBjjWBn6FN8efgH6o/Z1fiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YI795mrr; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YI795mrr"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dea50ee572so7488882a12.1;
        Mon, 17 Feb 2025 16:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739839879; x=1740444679; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA5+vy2BK3E8WNWxhr720SUyREiSZZlYrTfJGobjVLc=;
        b=YI795mrrdbrX12/oaoWBZm0+L26cBtPRD7F83giQX6+XmktDhO2bR7l09ztwh0z5AL
         6RMyeuGRlmCcQmpgGPC0NkIV7pQKXL97kKSCbjSk+YgxuPxWGX+giM5qoRicM5qpVaMw
         aDSC++JcpEcjKTMJooMXLngoocfaAdGk3aaKaheOKxsGuK76Iw0a0zs2W1BKODrv3Vqh
         trT4c1psgfmEhReSku4i0psuiziQrPRecNd39X1Vb5N9/A1P/4F7SgOj3lXVfYOvaRQx
         ARUa9mC5rOWRm2ViDBVB6C/UEu5LoXpdzUZfzBDHOd1kTydQoUT2lVrg8wLKdA1ej7P6
         V8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739839879; x=1740444679;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA5+vy2BK3E8WNWxhr720SUyREiSZZlYrTfJGobjVLc=;
        b=HAGKmkfJHk/doEiettiEZHmL3yZoEKj8JZgUxTWL+gdq4onZFprp71+xdAG5NVofDv
         kfDdLXKRB3ezKpOyW1cJ3xHla37ewJCr6wAUv5oZcQQn5EFKxT4Rkq6ZLKTnJRtqOpfH
         6d/+lNkAgcvcf/Kv9GC6jFuZUkVMo1qdpMPKmZyTILi+vZDo3tkGh0wwXh9MzLvGtSKK
         U/xZ/GcN10WpLNkzrKyezPq1AVKjaaUJoUwkwXPABwkCio2b1/X8sL7XqEj+du4+JgG6
         AwVxltfQos5YQ8U/dQjevzF7sRbieeS+FYTWvG5ciqkD/8lcNIyP1vG80sEVIICvzv/Z
         s38g==
X-Forwarded-Encrypted: i=1; AJvYcCVl0oH0RaQXieUoEnUQrga9TSy/nFY/fbxw/ZfE4iiI/8mniSWLr3RJm5qeYtbrOp3RiL/3s7bN/Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU8S8fhUhriMG7O2Mme0kyGUztIxQd2Lf7TO7Kb4mDFuyxd9gH
	zKePaSO3fEx5H/l5QeCYItk2zK4TUQPHF8QzLoPe/L+u8obwT6Zr
X-Gm-Gg: ASbGnctd0FfYqoMbfnmTufFyZ+n0czJOQ+bwgZELyNK458ulKz3LjyNg2kyeK0SOgBj
	eSE05rELXcCrWDwESxOg1cUTCLyUbdUw/qJjA5JlarDvuSEQh4QkTp5AQP1uM6RKkBtxqLRLMEk
	e/T+Y4EJfkwimCUA/HMRiYbhSwyp5XvkowtRjA/PIGxNy0ZDfUCCpg+tkj4jCCBcLKHUoq6MgU9
	r+2KQ2MVCYtu+ObKRKYDon5T+AFelvqMGmVuegxNj2vP+Sek9Rbdzt0a73/vaPTO7DHXpP6riGE
	XNRUy9dCpfX0OeM=
X-Google-Smtp-Source: AGHT+IH/SGvZ3jkeImyxXE5hT8PpupmiBpgpbuaKAsTMtBajDyNpiddyfPDv5GewmK/qniBzlEZqlg==
X-Received: by 2002:a17:907:9709:b0:ab7:d87f:665b with SMTP id a640c23a62f3a-abb70de2845mr1108304966b.48.1739839878490;
        Mon, 17 Feb 2025 16:51:18 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbb186c5d5sm90431466b.51.2025.02.17.16.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Feb 2025 16:51:17 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alan Huang <mmpgouride@gmail.com>
Subject: [Patch v2] doc/RCU/listRCU: refine example code for eliminating stale data
Date: Tue, 18 Feb 2025 00:50:47 +0000
Message-Id: <20250218005047.27258-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>

This patch adjust the example code with following two purpose:

  * reduce the confusion on not releasing e->lock
  * emphasize e is valid and not stale with e->lock held

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Alan Huang <mmpgouride@gmail.com>

---
v2:
  * add the missing parameter *key
  * make function return struct audit_entry
---
 Documentation/RCU/listRCU.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index ed5c9d8c9afe..d8bb98623c12 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -334,7 +334,7 @@ If the system-call audit module were to ever need to reject stale data, one way
 to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
 ``audit_entry`` structure, and modify audit_filter_task() as follows::
 
-	static enum audit_state audit_filter_task(struct task_struct *tsk)
+	static struct audit_entry *audit_filter_task(struct task_struct *tsk, char **key)
 	{
 		struct audit_entry *e;
 		enum audit_state   state;
@@ -346,16 +346,18 @@ to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to
 				if (e->deleted) {
 					spin_unlock(&e->lock);
 					rcu_read_unlock();
-					return AUDIT_BUILD_CONTEXT;
+					return NULL;
 				}
 				rcu_read_unlock();
 				if (state == AUDIT_STATE_RECORD)
 					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
-				return state;
+				/* As long as e->lock is held, e is valid and
+				 * its value is not stale */
+				return e;
 			}
 		}
 		rcu_read_unlock();
-		return AUDIT_BUILD_CONTEXT;
+		return NULL;
 	}
 
 The ``audit_del_rule()`` function would need to set the ``deleted`` flag under the
-- 
2.34.1

