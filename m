Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHwIyp6e"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB4294;
	Tue, 12 Dec 2023 09:47:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28ac11407cfso372931a91.1;
        Tue, 12 Dec 2023 09:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702403275; x=1703008075; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lpcp9URoW3Nxmv8uilTZFjiHClsiXT96h5WC+LC09D8=;
        b=AHwIyp6eWN96NQkVsP6j8AG/o4omFQPKqdlgqa1uYkstJ2gGyFZ7wNtlqNI3KzFo3h
         uEhCgL9TYTWRkfl58aGTFsUW6AqwnOqRzd7BE+fawko9iTzkznh5nxYMRCOZEvI9wjrI
         yQNhgUXEfm3fKhQr/00l5pSrGHx+UQVnCI5YPj/zvqXe7Y+CyqPejpptKtkR6rp+M7sM
         IoefbgaA7tAXxU6uPiXhenXDS7gQuRpWf4WizDJOSZ1Drrsu1CJ4tH7lrqFB0QjbhQ1R
         gPoywW0IiGGIb1YoLUauh+fnRg80Z7Jc1iXEJZlfYQrtNqhNDMPCQPspMCAWCCQE4igZ
         6e3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403275; x=1703008075;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpcp9URoW3Nxmv8uilTZFjiHClsiXT96h5WC+LC09D8=;
        b=dUvF/Bhu+SUzozID78n+fct8PapeoXQpfoj2F3vtMVmIchthE35YFMJlpwQ0fqUVff
         JfktiPJ2MbTQrjf5WMBWMnES0/4F2La1QGVcUXqK3zzLzwo9ZxpRdUl27Y7V4BeNbE5P
         nY0m9ndPtP2rwMqFvV5jI0Lu4lF6K8/+VGjWLam3qgFL2CZzcQokSDIzK8IT/m7277BA
         jdZN0+mS8rgxyiG0/e1d2J/0lqLnt1YXU1WL7lT960h+E32oc82zre6LZjREI57q9I6y
         lq6y0a3s1jfTEqdeoB6LfbV05SyVXAMEgeL8JrV1dmZGghPGymkLNEHY92WLTov3DxDE
         YVkA==
X-Gm-Message-State: AOJu0YydioepTpCQLI7XFxBSnABaHxWxs3djhiC9QSSXt46nO0A2g56N
	ywXS7eVnLgfQGTiBoaqWDzukmvmna9StqdZb
X-Google-Smtp-Source: AGHT+IE5We6VeCbXzoTpALvI+cZjFzQ1SripHmBSbTqDFzpmZuLx01H3+4+b0Ns3CASoMQ//PPIJvg==
X-Received: by 2002:a17:90b:203:b0:288:898d:70c2 with SMTP id fy3-20020a17090b020300b00288898d70c2mr2894098pjb.4.1702403275546;
        Tue, 12 Dec 2023 09:47:55 -0800 (PST)
Received: from neeraj.linux ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id nl13-20020a17090b384d00b0028adcc0f2c4sm64200pjb.18.2023.12.12.09.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:47:55 -0800 (PST)
Date: Tue, 12 Dec 2023 23:17:50 +0530
From: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	paulmck@kernel.org, Neeraj.Upadhyay@amd.com
Subject: [PATCH rcu 0/3] SRCU updates for v6.8
Message-ID: <20231212174750.GA11886@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This series contains SRCU updates:

1.      Remove superfluous callbacks advancing from srcu_gp_start(),
        courtesy of Frederic Weisbecker.

2.      No need to advance/accelerate if no callback enqueued, courtesy
        of Frederic Weisbecker.

3.      Explain why callbacks invocations can't run concurrently,
        courtesy of Frederic Weisbecker.


Thanks
Neeraj

------------------------------------------------------------------------

 b/kernel/rcu/srcutree.c |   10 ----------
 kernel/rcu/srcutree.c   |   14 +++++++++++---
 2 files changed, 11 insertions(+), 13 deletions(-)
