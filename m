Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA785C99;
	Wed, 24 Jul 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827836; cv=none; b=UAMto8NSMCnSZ5mMvBDhGGkR97wJ6KxBdIUQwzd2Hh+naPxVTF6n+jo/0tXR8rwGHawc1AnB/huNLs5Dekg7ZYqusC+1U5ZUcgBzAXjsiXjY0pqRMCo6kmPFGA+/1BpwhzDzsdajpiGGugok+EfGuRED5ETLA6S7BIJj97iZhJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827836; c=relaxed/simple;
	bh=rXsBJiN7JR7yUyOKBqNLjwF/QSh5GPtuP8ZsHje30Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj+q6ugy5Ao2C41z84Bg8vleHHxJVMmSZZOEC5ldtuEPvVZZ/QG+YJfkR1zrZFOW2m6yH+AGdyqAB84TcZnI/umUhKJ+Ph8mBHs1+s0++1oKJjLrXaAKcfoBDjZDuGEu3EZL4xLNm9Uf0LEloo08dIPUgcX6elValunntg5Xhdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so6096401a12.3;
        Wed, 24 Jul 2024 06:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721827833; x=1722432633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZqRrIuM9jE9sF0gmCACn7o6Ts+S3Lj7/WvAOaIfhx0=;
        b=HHlaGhq7LKbcyCYd8BfXQILjUn3guegTYUn8jvEERTBuei+gHGFGNdVt88TB3V8Dq8
         io5UhmEN4VEMiQSGsjOSIjN0STN7vaIqyjKgj07woG/ExaADmXAvu7TdPKb0cbPEqoGr
         fBM5Y2IPW1dEmqz8lBtceMSis2HgTtQqzV3vExq2q4t8tbEZeCEdZWL+W0QO8l9LBabO
         LNy9MN1JdMhPLqAzHMtJbiuEYpJo04keDSjEpFiX8Vhv8QQpksr/78yAwnbkxUw83O7Z
         LO9k2ayTx8nA/Tb5CVJQU4jQVvdgVVC3j3liWZVJ2MXnfZmncqQOJH7LSVBa+WvtFa/B
         708Q==
X-Forwarded-Encrypted: i=1; AJvYcCWcRqDPXM6YNlxrQYrl7iIPZnR5AUivVuDiK5u3tTaX7cHr7j1yQ2UnxT8tYUYXtC8NRjgO1tz9kNsjMIOdZp4GHuu6n9fpb64jL2A0KNjll52iy2+1aNT0H8/XL0PwoB5B
X-Gm-Message-State: AOJu0YwjfB2EH7FurUogRUILJsJW9BIAwnr8CtkbrvTJZtcbv7B1vNGQ
	e69YePQOVrcbo4cRxsPKuDWwPIwyd896y5r6aO72KOvpZocsUrHN
X-Google-Smtp-Source: AGHT+IH1eRhxJ8k1lt96LMBBzvoc8qe1HGKcJcrdY9KgXHQyocvyCfM23qmOi7h6h6e/6LONWHtYgw==
X-Received: by 2002:a05:6402:3510:b0:5a1:7d68:62d8 with SMTP id 4fb4d7f45d1cf-5ab3401ea05mr1125780a12.38.1721827832682;
        Wed, 24 Jul 2024 06:30:32 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a69c1f56a0sm5309602a12.64.2024.07.24.06.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 06:30:32 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:30:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Waiman Long <longman@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vratislav Bendel <vbendel@redhat.com>
Subject: Re: [PATCH] rcu: Use system_unbound_wq to avoid disturbing isolated
 CPUs
Message-ID: <ZqEB9Yz0womtmDRg@gmail.com>
References: <20240723181025.187413-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723181025.187413-1-longman@redhat.com>

On Tue, Jul 23, 2024 at 02:10:25PM -0400, Waiman Long wrote:
> It was discovered that isolated CPUs could sometimes be disturbed by
> kworkers processing kfree_rcu() works causing higher than expected
> latency. It is because the RCU core uses "system_wq" which doesn't have
> the WQ_UNBOUND flag to handle all its work items. Fix this violation of
> latency limits by using "system_unbound_wq" in the RCU core instead.
> This will ensure that those work items will not be run on CPUs marked
> as isolated.
> 
> Beside the WQ_UNBOUND flag, the other major difference between system_wq
> and system_unbound_wq is their max_active count. The system_unbound_wq
> has a max_active of WQ_MAX_ACTIVE (512) while system_wq's max_active
> is WQ_DFL_ACTIVE (256) which is half of WQ_MAX_ACTIVE.
> 
> Reported-by: Vratislav Bendel <vbendel@redhat.com>

I've seen this problem a while ago and reported to the list:

	https://lore.kernel.org/all/Zp906X7VJGNKl5fW@gmail.com/

I've just applied this test, and run my workload for 2 hours without
hitting this issue. Thanks for solving it.

Tested-by: Breno Leitao <leitao@debian.org>
