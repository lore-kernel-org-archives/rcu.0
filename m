Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E893A1B6
	for <rcu@vger.kernel.org>; Mon, 18 Dec 2023 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="AC0DHSfo"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cc6863d43aso16582821fa.1
        for <rcu@vger.kernel.org>; Mon, 18 Dec 2023 07:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1702913288; x=1703518088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Cj5RW2vsN4guuPeJ+n8QNc8sNSQ1zIxYgWq4v8uQ1s=;
        b=AC0DHSfokr1qPeKJbQQQVS5FZZ8z3qi6LlYgBYY1b8LQFMCf9sjtundnHO2lE9rN1k
         msIgrLLSghJSqBhnDK7sON+ZfVXBTgCBs8eq8eM9kIg2BjMiFVc6i9PXJHfhoREt4QOB
         G1j8dJr9j8jzxoQt1aLCLa/WHbewY/0C/Ow+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913288; x=1703518088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Cj5RW2vsN4guuPeJ+n8QNc8sNSQ1zIxYgWq4v8uQ1s=;
        b=k2oIwQnddng1KJHIgFnrd3UizVK5GS5PVfnF3dU0Ex08wpaf6LgJcqOv97mHS0L6IR
         nP2XeWE9ENCy8zmqMDmcWPGH3n7JoSq9wcufDgPxdAZ/cSOiyAVyi5c4fCKvBAzZb8n8
         q8li84AtXL5I1sH+OhdSiL92FOByOf2xR/toZ+oMAA4xhzm8VSTru9mtSsAj2+sxCKDO
         WYZKVV00EvhO2DH+3lZ3kP7ZHWj+luU4L1qyOJH5v3ia/cxiHpd65hzXylBkZKdNbebj
         wg1aEQGUGq5rSMF6zrD49ojrV8rexmBeaVXcCeXLbwDs5YjIymAtKHjxTQ0+DC0YSLmo
         MIPw==
X-Gm-Message-State: AOJu0YwJPPmvYNkKakJSgbcqvGg9YxIlpVBp3xqHf1xNwYEW4wF3D4Do
	JtRQTlslvxwC9yk7tQ+6KS8/gBKzuuHavZOzxtZOIg==
X-Google-Smtp-Source: AGHT+IENsSbjrmLeKvp9dBDMIsZwQFmKgADsbcB4V98B6wPQ+qLotMIjC9z04B7ZinwlZTTg5iW6kYrGaPyBJxTL65w=
X-Received: by 2002:a2e:818f:0:b0:2cc:5361:ae01 with SMTP id
 e15-20020a2e818f000000b002cc5361ae01mr1967959ljg.73.1702913288455; Mon, 18
 Dec 2023 07:28:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211015717.1067822-1-joel@joelfernandes.org>
 <ZX4T4E02hbsgnGBY@localhost.localdomain> <CAEXW_YQK_ct=kMKSO6XnW1NpSjSAVMiMevL-om_i-au9mpUEyw@mail.gmail.com>
 <ZYA3aiWbgzBNH3fZ@localhost.localdomain>
In-Reply-To: <ZYA3aiWbgzBNH3fZ@localhost.localdomain>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Mon, 18 Dec 2023 10:27:56 -0500
Message-ID: <CAEXW_YS-p9G=fLO+-vYx9RQS9oovHbVs48aPDfGcQrNWUdXwWA@mail.gmail.com>
Subject: Re: [PATCH v2] srcu: Improve comments about acceleration leak
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:13=E2=80=AFAM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Sun, Dec 17, 2023 at 09:00:15PM -0500, Joel Fernandes a =C3=A9crit :
> > "Acceleration can never fail because the state of gp_seq value used
> > for acceleration is <=3D the state of gp_seq used for advancing."
> >
> > Does that sound correct now?
>
> That can be confusing since acceleration relies on rcu_seq_snap() while
> advance relies on rcu_seq_current(). And rcu_seq_snap() returns a snapsho=
t
> that may be above the subsequent rcu_seq_current() return value.
>
> So it should rather be something like:
>
> "The base current gp_seq value used to produce the snapshot has to
> be <=3D the gp_seq used for advancing."

Yeah "base current gp_seq" though probably equally confusing sounds a
bit better, so I'll just use that instead of "state of gp_seq".

With that can I add your Review tag?

 - Joel
