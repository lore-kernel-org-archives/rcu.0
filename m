Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D582B3E7BCB
	for <rcu@vger.kernel.org>; Wed, 20 May 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285771; cv=none; b=ROTOYhXtDzxQeBlM2u5XDo4ajOtZTRRf3af8juXg1lT/UMZj9ECO7jRNhhgtcYgo7IMzIIS6cqXObF49Cv6M7Q+SaBAB6WY9XO21bbSE+od+3xXm9oDZ4z4J3ykFJPpsKfs7bSDvShuJu3ynVtlIMNpN8fPr+o7/GFO+xq1D0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285771; c=relaxed/simple;
	bh=FSMtctQdww+HEc+hPRzVd+J9wZaaN+9QWgQPg3FEMeU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5aDRYor/TDT0aPi7veQte12liRw9vM/NzYI5Rlt1VIBhnjUy2vjH0cHFT+v2q6IaTbZteUHZ/8s2ZvxgRmrHZ/VPOrcg5zHV7g9/g1Tcg658Y6ypfVEdYL0EpVZhtyrFKZvCbhb4k7stcI0GAH2bxu4/1mO46k1kn9+AVAhLsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btYVc7DS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btYVc7DS"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa2691db86so1705202e87.3
        for <rcu@vger.kernel.org>; Wed, 20 May 2026 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285768; x=1779890568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P/BFjjLcUpMeKtug7IfWPCG5R345sMYVMESVBGeLr1E=;
        b=btYVc7DSZGXkjADWT+ePIc1Rry/LHgTDpFxqMGYLuhyYTXCkpIKHggfDLtbSEXGNm4
         swIfVTUhlA+ho3gvJmT83DWlarHxppDjkiNR9Z9j+ZrXMk8ry/+vxXzL1Q3B55J0Mykf
         G8Y/q5uOBfI3ftn8WA5o7lZrWtRBybJqq2YD9+MfZKjGOr2IiH2ArZAZJCNzKwC2yEYd
         e52uOmxpfdeLS0TaJr1lK3/caEKZZMyAAcboVrdLsjag7rNUE/H0eKpXRNMx5r5FsvvG
         BpKjU3RKEKpILMbwXyo0TfWpklFrhLH2yjlORyEdwMZ7VgoEu+IKtC5jj4sBlgV/Gsfm
         g00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285768; x=1779890568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/BFjjLcUpMeKtug7IfWPCG5R345sMYVMESVBGeLr1E=;
        b=FUJqiYd9r00CEBPcSbmPd2JgtyNb4Nq6Z5m/DW/WBizLLMQuYlSnho91VyDq+z43JZ
         Y2xOjri1+vkaAVe1/kAVP/osq9OL+XP+nqcWIdf5X7WaXuhwr98GQN/i+fzTs53vyv0v
         qx6EWUmLjAsnWysedNJw4f2x7mbi1aRN8rX0Ro+zUSfd/rfYkwwrR5VxTEGmJiK3Cvhd
         jEIeDBBDprByGrCYyTHsF4NgRT77Flegqpmjq3GET+L8a3WnUAdDvG2kJJjhSyIiVYKs
         bGgILqTrbHOmpb9gk7L+yud5A+sm9bwp59WRIESdM51yDyqoZU3jPwzhZFZk0upjdtTK
         CLkw==
X-Forwarded-Encrypted: i=1; AFNElJ9UO99TkUSJeUkIXPvZUCLRO7zlZMdX239WdfBv4M+I0YLhMpk7y7RhlCnQIEZ8CGErMH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTsi89RFXiM7KWiODsm0xMALjFnekJz8zLpXiMWnDrGTsG7yx
	hAnvx/G/4rZsQe6d7VsvhKs3vCAyTPrNekdzlXAK4p25/14PD7Qeuya0
X-Gm-Gg: Acq92OEZoWNCC4JLwONMWC4xppXJek8QF56f9q2nuXVdQ344ig+jIXvPNoE4njB3Aum
	AfRDc+/6GXJ+S8Ew+U+zdbHNweLLv/OU5mGdlzNZXSpUo7/zIaLq0OYBJHcYKGFxNALsAwMecrC
	iL9bnQLBlumW6AukFBCf3quS5TSpLUFWeZ/za6S0HZU+zwxztQ5ODmPEZ7waV/dJdOYWMzkOdIK
	t8nVCJHLLBIKu9nf9mMdIAbR4X4FfkDwpgU8wQW/yTeZkT+GrS6VNZJVfCj9rKWVtWh79JqiHiH
	XEP+7SGh/Cb9m6to/Ql4HnZ77XgnXGT57G54DrMRt7bsN5oX9opPHW+gqGRR3KH7hVJRbXks3qK
	GYFzZX+2FGTDVPwkT1wmYZZ2YsJLeGbb0yKMHuBXXb0L8Z4xYtaMm8tkxQWFrrOkd
X-Received: by 2002:a05:6512:10c2:b0:5a8:74c3:5d9b with SMTP id 2adb3069b0e04-5aa0e5ec491mr7536984e87.0.1779285767649;
        Wed, 20 May 2026 07:02:47 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a90f11ad33sm5047456e87.33.2026.05.20.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 07:02:47 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 20 May 2026 16:02:45 +0200
To: Frederic Weisbecker <frederic@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Ingo Molnar <mingo@kernel.org>,
	Tze-nan Wu <Tze-nan.Wu@mediatek.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: reduce stack usage in nocb_gp_wait()
Message-ID: <ag2_BRvjDMnsarVx@milan>
References: <20260519190447.1716375-1-arnd@kernel.org>
 <ag2jMYwauyQPODdk@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag2jMYwauyQPODdk@localhost.localdomain>

On Wed, May 20, 2026 at 02:04:01PM +0200, Frederic Weisbecker wrote:
> Le Tue, May 19, 2026 at 09:01:28PM +0200, Arnd Bergmann a écrit :
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > When CONFIG_UBSAN_ALIGNMENT is enabled, the stack usage of nocb_gp_wait()
> > grows above typical warning limits:
> > 
> > In file included from kernel/rcu/tree.c:4930:
> > kernel/rcu/tree_nocb.h: In function 'rcu_nocb_gp_kthread':
> > kernel/rcu/tree_nocb.h:866:1: error: the frame size of 1968 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> > 
> > Apparently, the problem is passing rcu_data from a 'void *' pointer,
> > which gcc assumes may be misaligned. When the function is not inlined
> > into rcu_nocb_gp_kthread(), that is no longer visible to gcc.
> > 
> > Add a 'noinline_for_stack' annotation that leads to skipping a lot of
> > the alignment sanitizer checks and keeps the stack usage 60% lower here.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  kernel/rcu/tree_nocb.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 1047b30cd46b..373b877cf171 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -655,7 +655,7 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
> >   * No-CBs GP kthreads come here to wait for additional callbacks to show up
> >   * or for grace periods to end.
> >   */
> > -static void nocb_gp_wait(struct rcu_data *my_rdp)
> > +static noinline_for_stack void nocb_gp_wait(struct rcu_data *my_rdp)
> 
> This probably deserve a comment though.
> 
> Other than that:
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> 
Took the patch and applied the tag from both!

--
Uladzislau Rezki
