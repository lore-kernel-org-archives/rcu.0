Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D851BC35
	for <rcu@vger.kernel.org>; Wed,  6 Mar 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765062; cv=none; b=q75UNzuQ4bLqEQw8NcLf2oq7cmF7LcctKgWwJWIjq0GGSLZeMSumnzQkmNZJ3vm2zcc4Eq0LFyos8pypXqkvo4guokUaasi/gN8wjWrCslbRErpfZllsBsNTbtNDtRw7gYL4pYl8YAA6gDOBZH+PFEAqt377WJlqSqY4TU5wTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765062; c=relaxed/simple;
	bh=jcXSGLvSsNQ+837L6bjKovQh0l0mKvXmOQiuZs3pLv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZEW7q4tqwJaNwq9nN9W6+fJTGv9rTq/G8mmVeL+JkCQSZ1MnRPMZc+tmpIFj0izF/5jvmwIQh5jwbEF9PlDpBCISWBHQy2xywn796aesmudB/f8KTPBP21I8Pa9+cQ2v21pdTZ2j8dU5kcXjZOebGRHirHdCbP157W/KKys/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=GHBF2p9L; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GHBF2p9L"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d288bac3caso2110491fa.2
        for <rcu@vger.kernel.org>; Wed, 06 Mar 2024 14:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709765059; x=1710369859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcXSGLvSsNQ+837L6bjKovQh0l0mKvXmOQiuZs3pLv4=;
        b=GHBF2p9LwTKnH6qPltIk8moSS06iMyiF8dwA8P2PHs4GO2M3qzWv71d3lMTSQdO70j
         ck3JVBfpvx5So8g1sGs2wu/k84AIh29aRCguB3kD9aQ+QUYicyssg9+VCdNQl5RpMAr7
         L6zMEUJl90BZFSnhpm6WMt8/Sa00tlOFBTVzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765059; x=1710369859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jcXSGLvSsNQ+837L6bjKovQh0l0mKvXmOQiuZs3pLv4=;
        b=NYYciOfnSAA02Fhc22WcFAVVZmxP+DaL0RUqReZVjXp/nW/8iLypylmbEG2/54lnAX
         qicgG8hopqNAqefBx4z9gaqrstDRp4NsQDIGZEdbwjy50sxyg5AlUtzJtvwMwELxHL5L
         GujiresG4ytMbh4ZIeqFdCM5RL2Uaz9eZTdxN3aWWXRfw966nUkdvEnYoVcMTlVFnM/6
         GTDwA3n+KQBnxTZ0dLHkYwIZXQ84sCm6qduzONwwW5KBERcmXb351Y3yAwQO87DuN8eP
         6KRaU4xyPpvxf5g7LTcsM9BCWTY+p8suJbJbbQTELRizuG3G/YGVR41pPeUwwk5Dzbre
         lSbQ==
X-Gm-Message-State: AOJu0YxzQT/5FQxn4nIgECCCm+z98e3sxTbjRNttZCO6xjrMQ6ILBsoc
	U5LJNB8YyHofdhZBpUgtEWltDGX3pJzW484/zFs5vkGmv/14F3BsG/F27j+Vy567XC0xdvE4ot/
	F1UgSpER5YdJNiJxNj4XXrjv0ezMluKrpkf8ukw==
X-Google-Smtp-Source: AGHT+IHzlrJYF1P91BYKHk8y7TVpLavPJyNGKgpSg0CVZsTmR9LRYk1TxAXG3mJM6JYcYOirnDOciZ1xQicqUDGVrhs=
X-Received: by 2002:a05:651c:220c:b0:2d2:65b9:b420 with SMTP id
 y12-20020a05651c220c00b002d265b9b420mr229434ljq.1.1709765058444; Wed, 06 Mar
 2024 14:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305195720.42687-1-urezki@gmail.com> <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
In-Reply-To: <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 6 Mar 2024 17:44:04 -0500
Message-ID: <CAEXW_YTzMPxdm=UmMScppfP2WTqoyo6Z4c0p06HNgT-NAL2ciQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>, Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 5:31=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
>
>
> On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
> > Fix a below race by not releasing a wait-head from the
> > GP-kthread as it can lead for reusing it whereas a worker
> > can still access it thus execute newly added callbacks too
> > early.
> >
[...]
> There might a way to prevent queuing new work as fast-path optimization, =
incase
> the CBs per GP will always be < SR_MAX_USERS_WAKE_FROM_GP but I could not=
 find a
> workqueue API that helps there, and work_busy() has comments saying not t=
o use that.

One way to do this would be to maintain a count of how many CBs are in
flight via the worker route, and then fast-path-free the thing if the
count is 0. Should I send a patch around something like that? It saves
1 more wakeup per synchronize_rcu() I think.

 - Joel
