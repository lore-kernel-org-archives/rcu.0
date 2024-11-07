Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7B212D15;
	Thu,  7 Nov 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988089; cv=none; b=RqQhbdce7BU4JWR2UGQ7SAifnKJCoHzgXyrdkkYRPJzdVGLZXa/5bK1+5dQWcI781/OotBuYTCXNMqsJFKMd3jtYSGSyP+TtKkTz4Ew4fdLN3TXJUGY034e6hOT+bY2IV5FgfOmnq2uuU/IEpcct4CIwPRqIN9qcEXLlTlT/zCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988089; c=relaxed/simple;
	bh=bERWxv0yBNLCYKkdkDeosmgXgUJDBZCv7tCdQFJJi+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=seMHau+rIFjbcOvwPSUOgz5HpN2k36aBBooYnZx9ZiUJj37YGNAEDV2T1MIx7smihPEMpGIrIjxgVc9XN8V6vS4YIRjp6p494/9rZK+sZwuh2346DmcvwtsQpR4FK+qj64eD/6DxKc3tgxs8iZn6aK6XEQd7lrBDVSTWm+T16Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNJ5L/n1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNJ5L/n1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c7edf2872so17692865ad.1;
        Thu, 07 Nov 2024 06:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730988087; x=1731592887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrQo9kt5VA0epHBP1sR1/WuwlnoI7aHppL7SvPiuELs=;
        b=aNJ5L/n18Ku/8EXY5/BD6TuiRn52dX29EioRWoQ9Wh0sZFkYUCxpLlhpPxcQdy/eWi
         jhcWDlWGnc2BaJ4TQyEiaDqsrKHpemMjVwg39xPkXEsqC7WWYZr1KnvOvSTosTiMG5p0
         OnJinlEzBXoWwtGb9VuIdzQCz0JPSvzMO+woKmo6Hkkdd2nbBSyqQLQJCNMcOXDfkxYo
         bzVurE5KZBAnTe6mH8UZAZGYe645Nc4oEKFXYiqKolyIBFCXJHRvK2ARrWd5IMFKK/IJ
         tIqRJzD005lYUQ3+hMdvjbCZYrdsQjoVWLNvtFZc2nwugy7A/Hf7K5Pr9Qva52cLF3KN
         0XQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730988087; x=1731592887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrQo9kt5VA0epHBP1sR1/WuwlnoI7aHppL7SvPiuELs=;
        b=H0C1kKzjjPREOBaPNO24D0EQWI89rlcl74HbfZrHsqPphlHXZHrWzux2LlyNELPjT1
         Cmq3WQMHBHQGiPC5qu8aeAXNm8/Rt/HsJXWLdXNUNxd9AXWQ9t4ulugSiyRqPxR1vAZu
         UiofhP7qfhuSihigHX8p8aZax27z0Tap13J1yDpIq3eqC+yOiDGHkk5TqM2WoKLM/3p4
         3YvBIz1RG60zIb7MjHX4D4Hmcsl/PG3cGyUSpJtp65D6I+kMVTVKwGL7oBMYQFUSO/Z+
         f+Bggi+9VwqVLKMeZZ34UJRcyMo4fcuKmdFq6Zg5Fe6xYL6qg1D+AjJZChHyvwK/spxY
         q1sw==
X-Forwarded-Encrypted: i=1; AJvYcCVgpyCEi8H6Nkp+YiX+eNqiTeqbA8rlntTei2VUxIkMowcrZZxXcbv/PMrrncxEtPDI5VwG@vger.kernel.org, AJvYcCXLcjLY6WKqKv/+Y61sbePaqX9ZphSky+DVCBHb840pIAABBwJs+TwaG5VY2RQX441ni0jvdyhJAyxksYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvczrDFNl5KUiBKwiHg875bowjtk+nuMZ6ZArRj944IY6IHH3X
	mIOMBiabToMx4o8FtZKorGA+ZK/UawQE4OfojHO1rLeqMvHJnHnQqmZjMYyL
X-Google-Smtp-Source: AGHT+IFjpcdwT5eyvS026qurNh9wa44XJZS1LiyOziKBw5YB+DpcVbQLJK+SrQhIGWy+/H4ttB0IbQ==
X-Received: by 2002:a17:902:ec8b:b0:20c:68af:a4e3 with SMTP id d9443c01a7336-2117d2028e1mr22538245ad.22.1730988086691;
        Thu, 07 Nov 2024 06:01:26 -0800 (PST)
Received: from localhost.localdomain ([202.119.23.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5aa01sm12240325ad.211.2024.11.07.06.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:01:26 -0800 (PST)
From: Zilin Guan <zilinguan811@gmail.com>
To: paulmck@kernel.org
Cc: boqun.feng@gmail.com,
	frederic@kernel.org,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	neeraj.upadhyay@kernel.org,
	qiang.zhang1211@gmail.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org,
	urezki@gmail.com,
	zilinguan811@gmail.com,
	xujianhao01@gmail.com
Subject: Re: [PATCH] rcu: Use READ_ONCE() for rdp->gpwrap access in __note_gp_changes()
Date: Thu,  7 Nov 2024 14:01:17 +0000
Message-Id: <20241107140117.3790954-1-zilinguan811@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <65bfe6b1-3bfa-469d-aada-8e79d1101d5d@paulmck-laptop>
References: <65bfe6b1-3bfa-469d-aada-8e79d1101d5d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Nov 06, 2024 at 12:18:25PM -0800, Paul E. McKenney wrote:
> Good eyes!!!
> 
> But did you find this with KCSAN, or by visual inspection?
> 
> The reason that I ask is that the __note_gp_changes() should be
> invoked with the leaf rnp->lock held, which should exclude writes to
> the rdp->gpwrap fields for all CPUs corresponding to that leaf rcu_node
> structure.
> 
> Note the raw_lockdep_assert_held_rcu_node(rnp) call at the beginning of
> this function.
> 
> So I believe that the proper fix is to *remove* READ_ONCE() from accesses
> to rdp->gpwrap in this function.
> 
> Or am I missing something here?
> 
>                                                         Thanx, Paul

I found this by visual inspection.

When reviewing the function __note_gp_changes(), I noticed that other 
accesses to rdp->gpwrap are protected with either READ_ONCE() or 
WRITE_ONCE(), which led me to suspect a potential data race at line 1305.

However, I am not certain whether holding rnp->lock protects access to 
rdp->gpwrap in this case. If it indeed ensures that no concurrent writes
can occur, then I agree that the correct approach would be to remove 
READ_ONCE() from those accesses.

Thanks,
Zilin
