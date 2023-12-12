Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BEj3u0tv"
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218399
	for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 15:22:46 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so73533411fa.0
        for <rcu@vger.kernel.org>; Tue, 12 Dec 2023 15:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702423364; x=1703028164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no1hU0qMSuRSxx9sOYrSnjnOEvLJ8QjMRFYjlFqCCek=;
        b=BEj3u0tvCRJPFXhezmen454eoyW4Gw3Ci8nPnHkqKMDX7zeDl1M2JpN/rb0gzbTIyG
         bKb7HwyfFjr+zpnPVLrncekK0bbPDhVmWZHCepZ0iLz8b3OvOqWPq9TN8WW+jpw5jwWe
         RoQrVZTve7mhbHQW/RWPrZIre1blC057jLs5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702423364; x=1703028164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no1hU0qMSuRSxx9sOYrSnjnOEvLJ8QjMRFYjlFqCCek=;
        b=HZl3QZg51S9GZazXn+bf96DCLCVu70NntJ36nkdk73iFyZHBs3aIEZRQ69PPix8UQ9
         u7+7l4hGrCCMi1yBJ2utsd8SMBKGAgPye/x1RLnuizdW5kFBmu1MEvi+0+UPfQqol4gt
         GHcc1SRnRID3uVGVAcHMFZD1kdED7wBXiyI0Dr8pg+cknnic1WRjCbnMaKfvoDG62H2y
         SdUlOCXUxb576RkDXHvqgec0Hj/wN2xuwWp/1ot5pQ8SSD5OxWHDn+mQq8Dzb0sFHE47
         HMtRjb4Z2C4jCl4MjQiDbatS6tTrq/dXY7XffWSrFhN1lbjGXDfSYl51Y/UixSlyYalM
         cYRQ==
X-Gm-Message-State: AOJu0YyhWHkPPtzXjVHQ/1eKjBbgsjYLGhq9Dp2Wb3TxiIPdp6QNZEkv
	Ka5PU3lDHY8sz78EB1eJqOAFLujFIiy35mo/dp6R9Q==
X-Google-Smtp-Source: AGHT+IEQ6wtktPNRubmE3KWVpopyvCvh2KeO22rY2zJ3zKe33/47PK6BbVMmMeCeMiJSAWlxlclHVJ3rxT0GKarkw7Q=
X-Received: by 2002:a2e:a808:0:b0:2cc:1ec0:a75a with SMTP id
 l8-20020a2ea808000000b002cc1ec0a75amr4618551ljq.104.1702423364396; Tue, 12
 Dec 2023 15:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212173948.GA11724@neeraj.linux> <20231212174004.11754-3-neeraj.iitr10@gmail.com>
In-Reply-To: <20231212174004.11754-3-neeraj.iitr10@gmail.com>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Tue, 12 Dec 2023 18:22:33 -0500
Message-ID: <CAEXW_YQSPfv50=KNKp-rBVNDPw+XkQ5tUxbVZUL5TW0VVUvVuA@mail.gmail.com>
Subject: Re: [PATCH rcu 3/3] rcu: Force quiescent states only for ongoing
 grace period
To: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com, 
	Zqiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:40=E2=80=AFPM Neeraj Upadhyay (AMD)
<neeraj.iitr10@gmail.com> wrote:
>
> From: Zqiang <qiang.zhang1211@gmail.com>
>
> If an rcutorture test scenario creates an fqs_task kthread, it will
> periodically invoke rcu_force_quiescent_state() in order to start
> force-quiescent-state (FQS) operations.  However, an FQS operation
> will be started even if there is no RCU grace period in progress.
> Although testing FQS operations startup when there is no grace period in
> progress is necessary, it need not happen all that often.  This commit
> therefore causes rcu_force_quiescent_state() to take an early exit
> if there is no grace period in progress.
>
> Note that there will still be attempts to start an FQS scan in the
> absence of a grace period because the grace period might end right
> after the rcu_force_quiescent_state() function's check.  In actual
> testing, this happens about once every ten minutes, which should
> provide adequate testing.
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
> ---
>  kernel/rcu/tree.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ac3c846105f..1ae851777806 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2338,6 +2338,8 @@ void rcu_force_quiescent_state(void)
>         struct rcu_node *rnp;
>         struct rcu_node *rnp_old =3D NULL;
>
> +       if (!rcu_gp_in_progress())
> +               return;

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

(Probably no need to resend with the tag, just update the patch in the PR).

Thanks.
