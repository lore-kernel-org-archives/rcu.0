Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375244;
	b=LwKCEqivbcx/dXdX0U0LUoIzgKPv4QtbMJn7SqYyiCk3eagoDLPOCfMCs/O6r9IATSI/
	 BC7e16J54ID+WwFvqfTF9mSs0Q8DW9gOTQDimvOWyXxeVQ/HHNiTkEcsyB3540zbxKPhe
	 RWJbZj81wbAqjETSelX66C0NdllnuvNSHLVyR5zdle6cutGPsx10H7J22Anlb638alc1i
	 RfmvXyJUSOuE7dvT3B84iM91lbVUNTvlwxBGV1qNpehJfItdoOBCR8AsEuAk3Ao0z+dd8
	 HTdVgztb3Dz84P5QE1Vz2z3pAE06U/qhVGz7VhJkGBsEdfjZw3wXPxmGMiwiVktnx0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375244;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1FSmPlwQX8ZiVujfSQykkDxj0SSCHYMwsUrpHpmFlkE=;
	b=0V5Sifv5jufeFlFMqk3DSScCH9D2jDgIO//pyLnhkSe8XE5xJyNlL5RA216Nvej9rfP1
	 ydvwlIkTwHqiDu+ilmvLIZOB04QUrQfk5eRfvwGc08e7lFx7h0RUi+KWDxDqseGSJ5JTs
	 gqPE8pIRk4KKxMLOHPZi+OaOUAHPlC/FXKk9gv2ej3KR6K9ufKzdiHiJWe2y+CE6THVwj
	 2hIJEWTMcwF6KAlUsCceWzyEt1VWDj6WvHAHbcueiqE2dkKORxgBpmL1L7VyMYUgmBUBU
	 y0XzfybsZ2175ZqWzKcyRmhlUV6wVRq+9jB9BZnkerun5zPmbUeJLvs3oF6X6+HMjIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="czm/h+eB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8C606A320
	for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=czm/h+eB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9D41F0093C
	for <rcu@vger.kernel.org>; Wed, 11 Nov 2026 05:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794375244;
	bh=1FSmPlwQX8ZiVujfSQykkDxj0SSCHYMwsUrpHpmFlkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=czm/h+eBMfQ1+n477FDv4jREaIeSEGUdiCZ5RhrAZYlqE+jGU9Yv7tT0YCsRKz63O
	 vT4148f5TT5rVTx2jlOUmTZRHWXIpMC8sucJqxN3+dYvqVRVv/2ufsXJM/OWucaV4P
	 zoHFaIB38uZo2jSelh27AnNDQXYLsV6T7ZiNlBPh5GmperELUTnewy5vC0xLleVL49
	 onLjee43taSnGROxvKhGZSInaBzDhnzFy2ZDiVhDHsuuDO1vk8Yet2kj7ZGGsSRoOk
	 8dziyGVYitS9m/t6qg+Tv/LO02ZWYtCevJNIQKZ9skRms6TTrdvL1oFb04zql44zml
	 9D5l4BiOVyo4w==
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93cc1ab5f6cso355700285a.0
        for <rcu@vger.kernel.org>; Tue, 10 Nov 2026 21:34:04 -0800 (PST)
X-Gm-Message-State: APuU4Z9b31loxUfmj07nRDka7EoZgS5VmleDQDbxqv410eyneBJvN31l
	hSCSVTqpGgU10mVuJfeNLG9xZ5q16WB+5OWr8Y6yHYYqNecofzZ2DVFlC0s98ggevfuhC/etlj7
	x7LegOVu8zfM9LFa8S8liEUOhxEcxJII=
X-Received: by 2002:a05:620a:318f:b0:93f:11ee:ba5f with SMTP id
 af79cd13be357-947b006ea32mr221297485a.79.1794375243375; Tue, 10 Nov 2026
 21:34:03 -0800 (PST)
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
 <20261007204511.1982646-9-paulmck@kernel.org> <CAPhsuW6jBj1Sjm8SO_HO13oBgq-5gqKptgT_h3OWYoLDQggL7w@mail.gmail.com>
 <0952b823-990f-4a57-b090-f2cb1a1388c2@paulmck-laptop>
In-Reply-To: <0952b823-990f-4a57-b090-f2cb1a1388c2@paulmck-laptop>
From: Song Liu <song@kernel.org>
Date: Tue, 10 Nov 2026 21:33:51 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6_muF67Vztj1SxmamDjK7y6Ds815r3WBn8xVXdDqTk9w@mail.gmail.com>
X-Gm-Features: AclHuK8fUPrKgNHXu_Aq4UKpa5bxqhfOpnzb8gK1pwur722TdA3KEBL-EII2TLE
Message-ID: <CAPhsuW6_muF67Vztj1SxmamDjK7y6Ds815r3WBn8xVXdDqTk9w@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] rcu-tasks: Disable callback contend/collapse
 messages by default
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, Breno Leitao <leitao@debian.org>, David Dai <david.dai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 7:52=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Tue, Nov 10, 2026 at 06:35:10PM -0800, Song Liu wrote:
> > On Wed, Oct 7, 2026 at 1:45=E2=80=AFPM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > [...]
> > > index 627295396cd91..fcac7361ec51e 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -178,6 +178,8 @@ static int rcu_task_contend_lim __read_mostly =3D=
 100;
> > >  module_param(rcu_task_contend_lim, int, 0444);
> > >  static int rcu_task_collapse_lim __read_mostly =3D 10;
> > >  module_param(rcu_task_collapse_lim, int, 0444);
> > > +static bool rcu_task_collapse_debug __read_mostly;
> > > +module_param(rcu_task_collapse_debug, bool, 0644);
> > >  static int rcu_task_lazy_lim __read_mostly =3D 32;
> > >  module_param(rcu_task_lazy_lim, int, 0444);
> >
> > Rookie question: Instead of adding a new module_param and gating the
> > pr_info with it, can we use pr_debug here?
>
> Good question, actually.  If it is OK for everyone (not just our
> employer!)  for the global pr_debug() control to also control this,
> that would be fewer lines of code.
>
> This one is already in mainline.  If you feel strongly enough about it an=
d
> are sure that pr_debug() works globally, would you like to send a patch?

Yes, I think using pr_debug is better. Will send a patch shortly.

Thanks,
Song
