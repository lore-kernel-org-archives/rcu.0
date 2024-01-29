Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7176C8D
	for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550475; cv=none; b=Hb4vbnFgjQAuX+y/hRqv/GBLC1OcKY8nk87eRpyuYNnQRc9JM8k7YcDOvClSMyaDqUfEoGgGfDPKy8pYfbEcJSx8Y9LWx6rObmTexDu5YSFrC1nlQgedjCnfW4Xm0w5l9sZFE7JrrXqC+Zn0hcAVyoJ6zIMFGQyOz3OFHmJ+3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550475; c=relaxed/simple;
	bh=QXDkAeNurTjL7EBJvASewtl1foC1fp1hYHP1FuLXK8Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Bgxf4dlCnrMnlPRm1E7S/WxVUVFFllzrZsCEOPov7CKk0+mP6Z7ZDhjqL6Aa/c4BNhgqiXTdW7cJI1yUeKOs/OwEW6TNdvEArjA4H/TGjyoG2hRm/Miw1+UPRmylWEpEwEgx0ujycYda0SemWlL0FSUZxnLdf2YyWOOr33dOeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t0NiaAPg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t0NiaAPg"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ed3101ce3so45355105e9.2
        for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 09:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706550472; x=1707155272; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QXDkAeNurTjL7EBJvASewtl1foC1fp1hYHP1FuLXK8Y=;
        b=t0NiaAPg9fun12AIGFEKYU+FqDkdnmamouuUZ0wENUYdtOHk6G47KgMOYi0BnIHBRw
         iMynpsJjy9kDwtYN7QKqdUxYvaFat+cv9rvBhNAag3XXDNo0cCUn2hWSQmav3o3VwgEO
         jSu9YNDSZWvKEvBYWub0hoatf0MlwsQ5X7zt+UlSOMyLal+3dWfwBjexWVZFfGiUFOzX
         /0he5dPgd3/rVZzbqwNpbnPFLioMHUledZZNw7vqKbxbruanUHZ+O7avStl7q9YnNqrw
         ltS1d5BxHYPsW+Y4I1Qg3QbETZmrEAOw64En4BGO6RIs/BQjz90nYY6XF3qXNYdZs7Po
         IuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550472; x=1707155272;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXDkAeNurTjL7EBJvASewtl1foC1fp1hYHP1FuLXK8Y=;
        b=CgQa9t0Rwp5OlNtOTFnVFpF0vN4W728MzGOP4jZ0Bnz4+tMMrV7qMY2dY5ohM8WnQ6
         vyBAB/sh452fYqBKcNMzCKUu97sub58sM0RZomemzWfKleLI7KayAsDIjmkNarE+PBYU
         F3TzQCC/d0MkDaSXW2uwKVb0tyuGOFJFiiWR5o4TzBYVakenmeeN85CJMBNmuKw9Cq5S
         FE3UzVagDps/3cOEw7X0rav6jYD55C7J9SJ61RJCpsjQdTjmlRlTlwewgio4JYRaGFj/
         m/Pq4x4RpvogtLdb5knSSlxCPFdNEvh83OXmAA/KRKW4MAaAT+ia2s+YIvpfl8XzVUa6
         tEEQ==
X-Gm-Message-State: AOJu0YyARO75/9RG1c8lM9jfb2Nn0SIFWTiPXJ5VFmQ+EB0h75HgliK8
	8K5U3wMPN916RxLId33PDcRTpaLQTamBLr8CjGOFPVSHwUTQue5LWlmhMlYb98+ovFkKKGd1unw
	0ugd0EgALUG5The4IR9H3fHKk5Ke4viZ1TgenSMJtweaMtQ0kefLQ
X-Google-Smtp-Source: AGHT+IGqUktQWBWJOZEgghPJj6Hz+F94mDG34Ciy7DMUAuX1yF9ovLZxMTJFajyI1x3TnmonpFDIoa5W89FRcRNlFUY=
X-Received: by 2002:a05:600c:5487:b0:40e:a7d2:5a51 with SMTP id
 iv7-20020a05600c548700b0040ea7d25a51mr5369102wmb.29.1706550471909; Mon, 29
 Jan 2024 09:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Joel Fernandes <joelaf@google.com>
Date: Mon, 29 Jan 2024 17:47:39 +0000
Message-ID: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
Subject: Observation on NOHZ_FULL
To: rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Guys,
Something caught my eye in [1] which a colleague pointed me to
 - CONFIG_HZ=1000 : 14866.05 bogo ops/s
 - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s

The test in concern is:
stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief

which is a CPU intensive test.

Any thoughts on what else can attribute a 30% performance increase
versus non-nohz_full ? (Confession: No idea if the baseline is
nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
nohz_full on some of our limited-CPU devices :)

Cheers,

 - Joel

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2051342
