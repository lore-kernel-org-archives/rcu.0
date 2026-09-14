Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923535F18B
	for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789378490; cv=none; b=jqdSYDHGVgigbkp7sJnc/JkG0bfWjOMZJwM2sEG4CocqByceWewy2IX96DWPv8/HEjSZerpcapwB48u98Eva4DKxvcCxa2Psc9n5m9VeIRh8IyHNVz8b6jEr/v6SIEGAZ1e036gVVSyABLg3DmSRP188gfvwNe4ZtowSYmjuZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789378490; c=relaxed/simple;
	bh=eKviEVTWs4vlEjtdRVj1UZ3luaRzgOmRQm5Z+GX9I2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XD+NkYrHtq8G5kaJ1SFyI/lDL8Ln8NUUzicoy6MmPros2LjGHHOd6FvKWbQf4Ue2khCAo9rnlr2GfWLlWiEPUv1j6eny18sB96WotseBV0j1At5kFqrvv1/PU1Yoyk48d5glG42R+uujoYh9NQ8ic4EKx2+tf2zefzt3B8cgQ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RA8ZqsOD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RA8ZqsOD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dcff8f44f2so45222235ad.1
        for <rcu@vger.kernel.org>; Mon, 14 Sep 2026 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789378488; x=1789983288; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQy7dx9C3UiAaVvp/88A8jwcmWW/3O3E8NohA74NCWA=;
        b=RA8ZqsODFOUyEPbkLt1pI+YhI3TFGtOHih8xou9IU/CgMYPwQyYQkj98zuh2ekFEov
         jt5DuV8bVlxv9u+IaCxQmGwVzk59/J7wV2w3/IVIRiKG8qSRmf7G5dXdwplgmWBQxN2b
         kZMAqFq5/GXc99SEJeWsQMxx2wZ3neuoX+HIYJkfzvtbwGag71X75PubXuwPtvvNw403
         GCHR8g9C3/A0JF8kkJfZtD1LeUxdJklvM3QBebIvhJbch9vEZ/mLrtVl4EBmsPRir5Yw
         4YIptRxHrlQAaKfmuGtdirv4WYEKeKS9xQARCvjoSIVx7i3hSDPtCunA19oUiiwComfI
         J+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789378488; x=1789983288;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQy7dx9C3UiAaVvp/88A8jwcmWW/3O3E8NohA74NCWA=;
        b=QuO97r5YQx0Wm+qZrUXT/8Z4A9abzvXzsRgmJ5gDmrGoWq+Cvg8fU7U7IBSPRcA9ai
         WrW7Wy4CsrqTCLtMfTjCw/v0OL9yDPybho1R9BBO3wWkPUAV3zCQEllaqBZkff8/dLyy
         XT3m1r9bm/XOJXY9qjGit4uUCeMjPOVfSlCoEijAPp4DxH25TNBo0fx7YLsm2Lan5Xjd
         FVAfdvbNGmAF4o9uxWOLUNk4kJcz8ofUNYkH4aGDp8HsdwDrRmMorECPE1sLNUgCvInq
         RV1AoF4rkLMqN6E6NzkkVClRTGxO+qXLjR3hpwIEdFMZS9L+fhEmGyeLDap5olRA/b9w
         PRQw==
X-Forwarded-Encrypted: i=1; AKwUvBxFnPhIS5Ld4EtGaEfawB4EWQvjo8ZYhnA2ur4dqhhzESTfLFrD8f511VbD7ZbDKeo9vTA=@vger.kernel.org
X-Gm-Message-State: AFuF++m4OrZz3p7CmmVAYk4Lz98q4Eu9hZmSRnD8Q0e8Syb5ilJP1tkC
	PcbVIDJV4eAsx7KwboERuYjHfk9FdVG1uvV0Cw6/V91bc6VNAPQ/i20Z
X-Gm-Gg: AYBFou0VucUc2rSDaKM8uEbUVxE+INTWRRYXQi3bU5kr/66i8R62b4QKO5qL/HKzgAR
	lCKp4nZgcDvxL9JG7VKTPxnx4CaUXKe5E7tt+WPqg5bgWydUBDSyKcQIhINrN5bVKtnno1g1Clf
	86cPcrt/toRHT1S1qrgPocRJ8MsHCmG41IER/bMCNXpNsgQR/mZTGJX3bly2Xwphm/RWkqe7BHY
	NpVlQbStATPjOESgPHoOxnqzl9KWWmy8jdqTDEETwy0qVmpDozFLAEdENGy15oe0zZrnP8uwuw5
	i+OhzKEQVy+7VerupQF3haVzixQGqNx4wgYr5cZnFpqE6W9PP3taJoWtZA43Q5uEP1njekQ2PQE
	XYUG38S1W1TL6Sb4b9OX24HLZL56LaWeUSR8W1JDpj+IlDj1vB8sXXwIX26WyWEXQT4Mwxz2F1d
	nQKjIfL6b7Pes0pg1z1p0Lje5WymdJI2gF+k8BgXDaZbIRHLe9j3htNZY8wv/iM4G23MrvKckcb
	9NOKDvRUx69WI12SJDmBEOo53hK
X-Received: by 2002:a17:903:fa4:b0:2dd:68a4:170c with SMTP id d9443c01a7336-2dd6c6e73c5mr41907795ad.11.1789378488242;
        Mon, 14 Sep 2026 02:34:48 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfc2d3bsm46109865ad.48.2026.09.14.02.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:34:47 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: jiangshanlai@gmail.com,
	paulmck@kernel.org
Cc: josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 0/5] srcu: Add lockdep coverage for atomic SRCU and fix IRQ-state bug 
Date: Mon, 14 Sep 2026 17:34:14 +0800
Message-ID: <20260914093419.1474829-1-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The atomic SRCU fastpath enables synchronize_srcu_atomic() to be called                                   
from contexts with interrupts disabled. This series extends the                                          
rcutorture lockdep tests to cover the atomic SRCU path and fixes an                                       
IRQ-state preservation bug discovered along the way.                                                      
                                                                                                       
Patch 1-2 add lockdep test coverage for atomic SRCU:                                                      
- testtype 4: same-type atomic SRCU deadlock                                                            
- testtype 5: atomic SRCU + raw spinlock dependency cycle                                               
- testtype 6: rcu_read_lock() → synchronize_srcu_atomic()                                               
  legitimate nesting, must not trigger lockdep warning                                                  
                                                                                                       
Patch 3 fixes a bug where the synchronize_srcu_atomic() call chain                                        
unconditionally re-enables interrupts on unlock, by switching to the                                      
irqsave/irqrestore variants throughout the call chain.                                                    
                                                                                                       
Patch 4 fixes a pre-existing double nerrs count in the script.                                            
                                                                                                       
Patch 5 adds testtype 7: cross-CPU IRQ context mismatch detection,                                        
where an atomic SRCU reader held with IRQs enabled on one CPU is                                          
paired with synchronize_srcu_atomic() via IPI on another CPU.
 
Kunwu Chan (5):
  rcutorture: Add atomic SRCU lockdep support
  selftests/rcutorture: Wire atomic SRCU into srcu_lockdep.sh
  srcutree: Preserve IRQ state in synchronize_srcu_atomic() callchain
  selftests/rcutorture: Fix double nerrs count in srcu_lockdep.sh
  rcutorture: Add atomic SRCU cross-CPU IRQ context mismatch test

 kernel/rcu/rcutorture.c                       | 109 +++++++++++++++++-
 kernel/rcu/srcutree.c                         |  42 ++++---
 .../selftests/rcutorture/bin/srcu_lockdep.sh  |  77 ++++++++++++-
 3 files changed, 205 insertions(+), 23 deletions(-)

-- 
2.43.0

