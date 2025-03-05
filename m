Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D61A5BB0;
	Wed,  5 Mar 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193189; cv=none; b=i6nxtYlnhmAFCagW5dybiHgnvWksPhVjPbn98mCLYD/WPiJKWDBBYc2Mqp0h6N2Bj3OixdnCYtW8rbHlEc0uKyTE82ltJlkkOAixJAc4sBDB4oqRO5fUHNh/Hm8bc+krM+oZeGTPSVneO2vTBsdcb0YyG6j7EwFPMoYHh75Gbek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193189; c=relaxed/simple;
	bh=NenO5w4NxdLbkqYFrXeKv2KqYAGzxEEgxcF1Rx//Fbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/sjVxjvG+vCDJGgJ2JJGfcZQ3XnV7f5d1m9KpFwOCMQiBcOKuNQ2YNrw74M5dv3ZFeUOEq2NBkZkdcAUsfeE7PUBrgMRmZTwk6joflZ5aG+E2G5h8irQsD5V60+Dmh9JYyUFL10A5ngvuuXuwRcS41xOFhKsxeWQOCRDvx/bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIdgrFH8; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIdgrFH8"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e894b81678so35193306d6.0;
        Wed, 05 Mar 2025 08:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741193187; x=1741797987; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OcvdklEHsV9rwsQUlk2/UUT196cpbtOdI2b0X4kIbaE=;
        b=IIdgrFH88kqy4og8ThcIqEJBDeKcVOmnwd563QgdcipCH8XZ7KAjs05VKnXk8rmsHW
         6n2ZONjKJbv1EX2T1iaXpEEnQHiKN3oV5LsPgXfA5KFCNkdq6GCHgA44iyefvDSwmZRq
         y1ZDjTUpSA3D3UfxmQvXeweeP/i1KztF5/1PwSDoU7GiFtXWupTKpXLpaRXDX9g7JyOX
         nv9+Mv+DZyWqSNaKOENP8RKo7TMZzvFMmK72RpQ7S4xFRKXJIZUqFnj7Cr9JBwQf9K3J
         6zV1AiyAGH6PeL6PBNm6qhmZO7f59aE0pAs90wC4mj8cHq0bEpSNQHkp0RSPq+oKvKOR
         n25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193187; x=1741797987;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcvdklEHsV9rwsQUlk2/UUT196cpbtOdI2b0X4kIbaE=;
        b=kUWAfBqHftX0f9UG/h/zrsQkjEYhnCWUvXcdS1KYlYXXCecHqxs+E+1CN37e4+HFsZ
         fkj7kvPubjab7uETZo45ehEpWwlqnqVLrAnsWZxfTiJwbEiFnzthC2XaGuhj+/jI7QbD
         o5Lugw2d2DZnOwXHTFqfy8ugwy8JHxXneIafrms9CWD9oki/BqT3Fb5bhgHyeoccD1eP
         tga5seYHMOGXyDNq4wGQhIZlQq58zVVTLRqPcTSde8fKGN9dSjlaW62xvpef5hxssgvc
         V/zZyuLn/8GPbsj2fD5Z+8ph6ttCpMZXDaci7R9QdWes3lfGwmbGA44Z/hCTKU18zAjJ
         1TPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaFDDtIDJ/jOyuDH0PL4TmVanaQ3p/hy7bYXM5ZAnHsCvFPi02368Y1FrvwdzScxkeLOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSTIcoiIpYoHVZalkH9PKuLs1IiIPrc5Jye53oMnWs2N/59H4
	d7BSUYB+4UvJv7NO2jOq2y2Cj/fW5nsBsLZVNlI3j0UXaibW3+UE
X-Gm-Gg: ASbGncsosa28YFGvaJn9DqL8IoJH4cfdTBZ1kiS2OMO+3mte6/vUAPRuuOyC7Dd1XGZ
	b2LRBHBvDb2bb38XLWurYwOhr3zsJVqHdIxTVL7oP+6VA7tnguQp3xmInUipWCV5+AnE7Mh8Viz
	5NE29Qz2GI5PiLUpLlSLUyzQoEo9fhkbpIjzrWCuMA8LpSi+2NOvARF5qG5KUPp+WVYTJfAsi6C
	NEXgimJzmpOPOdp8I3KBKPKGM3P8yN3BzP3tJ1pmJnZqzW30qd2eFW3erbnVSxm8/rOeU2XyP83
	0DdfdlehSSUSuv4hp3W7KauAyLfdvwY2Z9Js1/FSUIvdEZG69nzkeLS4mmC+L1zWZ3b/BlM38wM
	+oh4YqNpvM52YfcxH4wh7OmzBrnZPfTxaltk=
X-Google-Smtp-Source: AGHT+IFCVsysGWNjLkZxA+lQfYV2JMq0o9EU0cgnQO+p3xPZvYgsdOwAlDNiT4tsCznAT2ywAT1CGg==
X-Received: by 2002:ad4:5f0a:0:b0:6e2:43d1:5fd0 with SMTP id 6a1803df08f44-6e8e6d446c9mr62238226d6.31.1741193186683;
        Wed, 05 Mar 2025 08:46:26 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976cc891sm82538216d6.81.2025.03.05.08.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:46:26 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id F38491200068;
	Wed,  5 Mar 2025 11:46:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 05 Mar 2025 11:46:26 -0500
X-ME-Sender: <xms:4X_IZzS50ePURHmeKjWZG7ZR3TU6_NpqVd6gI7AagjoXdpI9CoF1Sw>
    <xme:4X_IZ0yvlohTXfqss1qjlncu3zaEwirUbgvYesPYN0Wnl-RTCmHVcPLkCg49JnOUP
    n-GOqMd_eQ73spr1Q>
X-ME-Received: <xmr:4X_IZ41DFwMpZ5pmYMaLJlcZKWj7xzwx08fIKOvGzqhRGXmP8bDHhV4CQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddt
    tddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvdefgffgieejleetueettdeiieegledt
    vedvgedvjeefieevgeethedtveelueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedutddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehnvhhiug
    hirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjihgrnhhgshhhrghnlhgrihesghhmrghilhdrtg
    homhdprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtoheprhhoshhtvg
    guthesghhoohgumhhishdrohhrghdprhgtphhtthhopehmrghthhhivghurdguvghsnhho
    higvrhhssegvfhhfihgtihhoshdrtghomhdprhgtphhtthhopehnvggvrhgrjhdruhhprg
    guhhihrgihsegrmhgurdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:4X_IZzDddwiMHJfwwr5Cq9DpkXb73IrcD9-34KrUfTL59QE8atOXdg>
    <xmx:4X_IZ8gRRhDKQHjOEsQ9ihHZY7pV5QsuT_VYmkWQg5pJFyk8F3wMFw>
    <xmx:4X_IZ3reFTew1NVsJ4yIkP12mvX1KYST1rjobRydeSMg1iMkkm-0lA>
    <xmx:4X_IZ3jnRnEsF-I58eiWUWoJF0Ed6l6VQrJFbQvNqkzEaL5_vjDlkA>
    <xmx:4X_IZ_Qqd2rhxl_2WLbVM5GNYHBnDugQaE44Mx60H3BASJ2JDW8PU5v1>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 11:46:25 -0500 (EST)
Date: Wed, 5 Mar 2025 08:46:23 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 -rcu] srcu: Use rcu_seq_done_exact() for polling API
Message-ID: <Z8h_3xQWGNjIw7Uh@tardis>
References: <20250219124309.463702-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250219124309.463702-1-joelagnelf@nvidia.com>

On Wed, Feb 19, 2025 at 07:43:08AM -0500, Joel Fernandes wrote:
> poll_state_synchronize_srcu() uses rcu_seq_done() unlike
> poll_state_synchronize_rcu() which uses rcu_seq_done_exact().
>=20
> The  rcu_seq_done_exact() makes more sense for polling API, as with
> this API, there is a higher chance that there is a significant delay
> between the get_state..() and poll_state..() calls since a cookie
> can be stored and reused at a later time. During such a delay, if
> the gp_seq counter progresses more than ULONG_MAX/2 distance, then
> poll_state..() may return false for a long time unwantedly.
>=20
> Fix by using the more accurate rcu_seq_done_exact() API which is
> exactly what straight RCU's polling does.
>=20
> It may make sense, as future work, to add debug code here as well, where
> we compare a physical timestamp between get_state..() and poll_state()
> calls and yell if significant time has past but the grace period has
> still not progressed.
>=20
> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Queued for further tests and reviews, thank you all.

Regards,
Boqun

> ---
> v1->v2: Resend with Neeraj review tag. Rebased on rcu/dev.
>=20
>  kernel/rcu/srcutree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index d2a694944553..591371d62e89 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1589,7 +1589,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
>  bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long =
cookie)
>  {
>  	if (cookie !=3D SRCU_GET_STATE_COMPLETED &&
> -	    !rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
> +	    !rcu_seq_done_exact(&ssp->srcu_sup->srcu_gp_seq, cookie))
>  		return false;
>  	// Ensure that the end of the SRCU grace period happens before
>  	// any subsequent code that the caller might execute.
> --=20
> 2.34.1
>=20
>=20
