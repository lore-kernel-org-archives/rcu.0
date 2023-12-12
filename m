Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlavEJZG"
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2920CB9;
	Tue, 12 Dec 2023 09:34:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28ac11407cfso360952a91.1;
        Tue, 12 Dec 2023 09:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402475; x=1703007275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw+CIAg8alL2TfLLUR0OkhwDoqn5kHDhii4hhgbuJek=;
        b=DlavEJZGBXl+5cmGgQwEmIbxX3ePKQdO3tVf57LJ3ea6fpNAsL0uxMoBj0x/6JuVON
         IAFaw6Obb553wk4DkVLxVM2/Z3u2+dWQVC3gbvs8Od5Ng3clkQX0RUXmYyy56hv5A2kH
         LxbImWu9cXjKxj2OCoqpVgAVIyTWZVMliqbGzMjD5962ZmTfjQiQzAx6QkIqIOe047zT
         lwNFe++RtlMFaaawzqgjN8jZOtFH+/F8OUIEMqDYk5NS5AKWf9FswTyjnW7clLFDM49N
         eyucsIMCYaJ5Cqpuh1EI0CQ4yZC0H4rfHz24CLMslbhG/9pjzxaVRSwmiNuSkKMkcFYW
         JPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402475; x=1703007275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw+CIAg8alL2TfLLUR0OkhwDoqn5kHDhii4hhgbuJek=;
        b=lcbk5Um76aqpLyEVKqaY4AOORtdJ3fhdQDrx3uO1x82rbxg1SlB2C2HibfJspQrM0Q
         9o8Yy+Kw8OihtJwnStsmIPK3yNR6Bxu3jOPjSEIr2pcGsv6xBqlk29ryJPG9BFjFwmqE
         t1pSFj0PFe0cb65iCGrDIPj/Y8F253pJo6uE56Lr2KrpdlNuTHr3/Uf2VkYzXSmYlYeo
         w9KFaiTTN2mDRBUql4ITzqBtBUZBYdL/+JGln6Ug8CiKw/6Hd6ql3Wtrs2+ZF16CxMTu
         RK3OO3LH2UxEsBFj6LofEGhTr6JZYMBA9SMKAGo8J38O+kYTe93BO9VXPOK7xdSUl38o
         mx8A==
X-Gm-Message-State: AOJu0YxoC/i5CMRrpRdR1VnbXviX5fp0/8kbYC4zwdooDDCAxupCcrcf
	Z/B8Hjnr0ApnD3AhGeIh7lC8+QDgC8CVyOsx
X-Google-Smtp-Source: AGHT+IHdSW8OwThXU0yHzXVEdO4UM7Avlxx8V/jJBruEaZYEjcx6lbfWkqXbvpFhgg4PBpvW+oFCQQ==
X-Received: by 2002:a17:90a:3ec1:b0:280:24c7:509 with SMTP id k59-20020a17090a3ec100b0028024c70509mr2932704pjc.46.1702402474615;
        Tue, 12 Dec 2023 09:34:34 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id nc4-20020a17090b37c400b00285545ac9d2sm9213862pjb.47.2023.12.12.09.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:34:34 -0800 (PST)
From: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	Neeraj.Upadhyay@amd.com,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 3/4] rcutorture: Add mid-sized stall to TREE07
Date: Tue, 12 Dec 2023 23:04:13 +0530
Message-Id: <20231212173414.11602-3-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212173334.GA11572@neeraj.linux>
References: <20231212173334.GA11572@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

There is code in rcu_implicit_dynticks_qs() that checks for the current
grace period being halfway to the RCU CPU stall timeout, but rcutorture
currently does not test this code.  This commit therefore adds a 14-second
stall to the TREE07 scenario in order to test this code given the default
RCU CPU stall warning timeout of 21 seconds.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
index d44609937503..979edbf4c820 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE07.boot
@@ -1 +1,4 @@
 nohz_full=2-9
+rcutorture.stall_cpu=14
+rcutorture.stall_cpu_holdoff=90
+rcutorture.fwd_progress=0
-- 
2.40.1

