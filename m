Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31A29402;
	Wed,  4 Sep 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460785; cv=none; b=UvLJDopYVP9yT63W65wVwyFdELH95XOZbplMlyqwpaH/o4aRoQq39kqorh7NRl+3w+pQ3ZN0RU5e+mrbXYkNM2UQUi/307Q0F74bldOnpx+wHbzWJhG6/LQkCkCgfYDHcRFMPHVHVBdCfAcL2pz+xYMsVD4AR4RvpWQIhb2/muE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460785; c=relaxed/simple;
	bh=6aDzBtKmErAeDRhH2UevZcpPjDuLZhOTTHcO+4zxsXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QCSD6OVOrjKBClN5NVFW8KacMMtEBfm5QExGQSH11ormUlsKWvKV+YJdkHWHzyXh08kGd2FeFpkoZj5CQ9JcJR4kFrgyC8tOCskOJcahMsieL7h6ER4P38akQINCuu6tn2QjtqtaYKGniXoT4AnJoy80++Mw7KTfnjj1VgLbp2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEtGWkr4; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEtGWkr4"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f406034874so80578341fa.1;
        Wed, 04 Sep 2024 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725460782; x=1726065582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YVBUiu7O6zEyMcaehani03tQmAhOQarVx21y7gpLEM0=;
        b=KEtGWkr4uQPLo6tdxbLXYUiFZtiVEYUvsLjX/hjBwei04rVVVpz5kk4tutnfN5tB44
         PMcKbTuYEdz1QqMGxyCBw6j+JTUREHITcyhNlZ5OJVaUHzCRaaGG1vVPQ2H3BCBmrE2J
         RibS7xqI1/t7tX/e0qpimxICvon8j0AQEh4UJxpNNv33qLZ/T0PJFZnME7sSeX9/+vCC
         ge4bwbsckESaTf4WcY/5vd1zYlEs/Pq3cJVUBnSSLPqktwZWrnCI1BI8y5TE0ykBDPQ1
         8rCZlL6aMjHSYNQZ9YNYgD43GDIjJSTQkzjiuvIh54NRLjHlKIBDNOpAiZfwCY763Osj
         9uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460782; x=1726065582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YVBUiu7O6zEyMcaehani03tQmAhOQarVx21y7gpLEM0=;
        b=v++cecRXKkHYqYttOwAQbvqRnwBsNJ2j00xB7n9vco7828JpeXz0EOn9748drm5mO9
         WAhaH9LzkxAfbedKOIt/nqyI5tefQWUDSzChReQ7fW7keReUQSx9Iqm1FzOFrM9V+FpK
         1/ErHaGlnsZ2dWjRJ4CiNPUOqKr/efU8Sh8l2/5UHQxbNnTPd59TBpI3giJRs5nqbW1v
         iyn+EXl07uxNoYS61N5lWc9zA35I5L7BrVyJLmCOO9RPYVsygAI60b6lr194JUWoVlkg
         +aZGkNTvrEpuc8hoaB0dI/J6IBiu7BhPVwBuVSyho0zVpFu8WklR/gzgaaJK7qkUo/00
         e3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUfkxW+MtOI/9zcV0bCu8qdZR4dTm5lDN1ZRr8/jhna1Xa5HokwpjLqCgSCbFW0xwmsXkJeLMmgEh42Ydk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDLku9mxvVOWTxcdW6O3auRY0NT0ehwZ0v7tM9TPn15A2SGvgF
	ATk54+RKyr+IRsrsR/BE/kL7Xt2D+f6L1hroGI2aZNNdaib7u+gn9YYQhA==
X-Google-Smtp-Source: AGHT+IHEZqnJ/r7Vsq9zgIaMIObj1Al45QUxn9uBV5dp1ofp2e/AcjfuQV7Q1/nXOLAYU7oCV9dYNg==
X-Received: by 2002:a05:651c:1993:b0:2f1:6cd6:c880 with SMTP id 38308e7fff4ca-2f64d546333mr36075961fa.37.1725460780717;
        Wed, 04 Sep 2024 07:39:40 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f65eb480absm1375591fa.51.2024.09.04.07.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:39:40 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 0/2] Some enhancement for kvfree_rcu_mightsleep()
Date: Wed,  4 Sep 2024 16:39:36 +0200
Message-Id: <20240904143938.119964-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2. This small change tends to improve even more the slow path
of kvfree_rcu_mightsleep() API. It is hit when a low memory condition
occurs which leads us into two options:
  a) check if a GP is already passed for freed object;
  b) if not, initialize and wait for completion of a new GP.

The differecne between v1 -> v2:
  - Drop "Support dynamic rcu_head for single argument objects" patch;
  - Use cond_synchronize_rcu_full() in a slow path.

Uladzislau Rezki (Sony) (2):
  rcu/kvfree: Use polled API in a slow path
  rcu/kvfree: Switch to expedited version in slow path

 kernel/rcu/tree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.39.2

