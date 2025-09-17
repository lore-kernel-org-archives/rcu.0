Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99325FA34
	for <rcu@vger.kernel.org>; Wed, 17 Sep 2025 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124867; cv=none; b=LjZ0KpZYeH9hoaYcm0/ys2blqOKd8ScrVSWHZBf5HCa8La2FT95RBxIQB6Yc54cz8FcyANkKla467vQtODClirf9OSILnyFtW2py9Yp1h/DolLwt74lryWHE7bxm5i8UL6LRu+zqk4eC7oTBK/9gq4vY7j47HMGfB2WHkEtpe90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124867; c=relaxed/simple;
	bh=R+c35AuppakFE0a1IYStQD/Bya5KMo/q8zDUXOBtdQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syYikjDdx5Y1SsYeNFo7kY3jBkUymbRVS2nLF6Dzv9fcUfJUXWeFjqK2tMBKgJAlWCw6nCRO8K0qcrMcxURlmKvSl0M+sxy0P42UwLiMfY/f5Ip1VHagBUnMDPwdBlwEvhIR4pJQfzjBqMPyWka+e4YBPfpYKVwC120WR7YojB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eQQTboZT; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eQQTboZT"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3601013024aso8614551fa.2
        for <rcu@vger.kernel.org>; Wed, 17 Sep 2025 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758124863; x=1758729663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JHH0nWjRof+d38qRI7i6SC6thOcfFRvUhOi9KQmmkY=;
        b=eQQTboZTirZNi3pK0pgbsR9ahoXJ/Q/82zpG46QcQ19q1xnN6tPifSrzqAKHyLgotT
         eqUKRcnl7iBWmYFjorHEDjYC32DKRDRJRcWBaXlQanKxbuAxRk23viOFecKSKtqEmn6o
         FBufqAcE7ok6NEIo27V+d4sz4EOYE3StqPj69AaAW1vA8nXyybK2psM78Exj6Nu9Z7fl
         LQroFsIX1bOPa3WKNMcy/VLIFH59AuBfuyPpvBhAsPr+fdxb8avhhnCxmigK1tixFRXA
         RgY3YNGCWWw1EjdYoDUcQ0MzL43uuzeIdX/4yl7BWjbF9EHZlPQkl/SrhGzygAeg2xRi
         Mkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758124863; x=1758729663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JHH0nWjRof+d38qRI7i6SC6thOcfFRvUhOi9KQmmkY=;
        b=t5cKW6iQBi8mPhJ1uxG9b/2ZLhdQVtE0jumaYapOcjWqo/fkxOKPwiKC5hXOKlj4+n
         JjPnsSy3kCPKEyeqt+YOTl7C0sn6c+Id38fKJqSb2S3E2hn0RO/ODtjkKD+LW2F6muMN
         YyCTf+oOzjZWJP7egOVL2Ku+HKM6tZBnqQ9lSlGDOv89uLeGzVZHnQhul7wwMyuPZ57r
         fqQv6Ht/Zcn0lHc+HYuzmN6+bvM/622ZLz0n7JSaoXUzQVRXQ7iFEtCuLEeEiibhT+ds
         P+WlHbF/k86/e+UR774XwdXUM8taoCCMaZIB2MQarJqDtCpoLMlyw+xrqpxShHnW6AEX
         AwjA==
X-Forwarded-Encrypted: i=1; AJvYcCWBahJYKYyA0AfyTT8pD7iPOsvhwjoCfv4K7uhjdg6jmBnTNNCvPoOL1cfibLS7IYJYaiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKxQGOIo18Ohh7LyRcZuMt7/eNsjhXggC8xFkaTsU/hdtCeAk
	prBiOthvLDzUL1IOa4WeueocOwRWuOJshbyojhZMhuC8ZF+qlNDvK2rgEucTpxAoVTmvWCfy3G6
	rug+sJR21S4gVuuJZyn1Gr0u/I4f7jsDPS0exn27TDg==
X-Gm-Gg: ASbGncsMLpZj8VZEwaMcfgczx1pSQs6s18gRTRMLg3o5lMDiudo73x04SuAL1P7hhDA
	16vGUDsNqqvpRXNrBFxc21p53ucmUQQkvTPupJ+B9hddyY0W1QkKKxnqBJOLWUxbMfIXD1sMLfv
	wgkI8A3xutyn9G6YhBDGLrFdMmZw0+xK2/MvGmb5JeE8Q9CSSO48NjR1i/74BSoDrkZKsBR5XxR
	LBt3VE9Gn8aQB4JYzMKNYhEylPFtJEHcCScFzZ3
X-Google-Smtp-Source: AGHT+IE39hdC5ZGtI8PXvGdgL45ZRWcKVCKPPrn5iysgQEjnw6ihmVjEHLHg/DoBa0zjxyqogHxZ5Once142DTclBnI=
X-Received: by 2002:a2e:a546:0:b0:336:d2fa:b3b with SMTP id
 38308e7fff4ca-35f64836119mr9877501fa.33.1758124863287; Wed, 17 Sep 2025
 09:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090747.107232-1-marco.crivellari@suse.com> <c83ad820-3380-423d-aa1f-96e3cd2c56b4@paulmck-laptop>
In-Reply-To: <c83ad820-3380-423d-aa1f-96e3cd2c56b4@paulmck-laptop>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 17 Sep 2025 18:00:51 +0200
X-Gm-Features: AS18NWAV-ybV0eDyblgDlZq51PcF4JXkzDusen8CH-S22FCwqGierv0IIMtkEP0
Message-ID: <CAAofZF5BcRXMFynGnJty8g-yqEQiTVzy6sbQpvFV1_M53MCHyQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] rcu: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:16=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
> Queued for review and testing.  If you would prefer to route this some
> other way, please let me know.

Thank you, Paul!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
