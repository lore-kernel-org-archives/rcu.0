Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0EF37E5CB;
	Wed, 30 Sep 2026 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752100; cv=none; b=UbVSATCkS5+dco4gCuqQUlNkftGm2Ekz9DhJ6G6i1mlh4OgY+WuZdvk+CZ1TQndEGxP958sXDk5lQiefpEjApCsTTeE3Ug9fgwAk1sW3u3m12BzM6xWgTY1kBkKbllZK8cXO1yZ0iVHaFnoVB6iHsXmVJfT1wPs2usNyRHaJU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752100; c=relaxed/simple;
	bh=TBlTn7Swx/IDcLWNPdYyMUtPOHyjsbXmi2tLCe4pZok=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PZY5vkwoeBM4yYjAFl0sfksUKHRAzclpZ320YyldoXknXGsEidWkCO8z3BAXyixYQCaAIg4dpTu0aFhfmVATpM1AectMYWXDA5IvyBw37UZt8aO5kNiLXsyBVkeX9lJIlhuvR11dxzchSHyxStLOjJmVAPThRCsQ6KyVe/X8Mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R1MsTqL/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pc7nJ4VZ; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R1MsTqL/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pc7nJ4VZ"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id A43561D00704;
	Wed, 30 Sep 2026 03:08:14 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 30 Sep 2026 03:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790752093;
	 x=1790838493; bh=njI/jFH+TtCBf3BQoyzAR5vi2zmQd1x9VdhSoFl2afs=; b=
	R1MsTqL/1ut4iBGFaKXUcIDzlnT0RyHW7mNjPG81pwmCoysg+AUeO8eLc9a3PC/1
	7rXazjHwQ2ESU7r3uUu+tdf69EP6G5wwOAoRj9DG9afrtp5+KWAZranL+2DTbNXG
	j2ZoVrj2T4eSj19TobR0jkjrcWxd75RT7rXkHNrKEWPEn2CFVyPrYfCMzPOD+fZM
	N5mC0IoHEt4b+VVNFnEvG2/QFfB485pKNGodCLgs6zqVZztV8U9b626YxchERVRu
	ifFaq89Hn6IIRafqrE8TMaF18vLypfzkOZeNW71WSSZS5OhTk8YqVSNyCxD/VeBw
	hCN02yP09eeIPPeOn97IOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790752093; x=
	1790838493; bh=njI/jFH+TtCBf3BQoyzAR5vi2zmQd1x9VdhSoFl2afs=; b=p
	c7nJ4VZGjaeO3p8OLj9VjH81ACycgLvrgPSOKQur4+igmt9XkiA5Uc5W4Aoxuop6
	uv+OPtDv8u2mSjabrYxjwZ1pr349Ljt4tdvBI3M6l7swUGGrgSvz4DMEOqb5QJsa
	/oAm12YgB/QNkuyfVoZYy9Y5cDcs5WLegvo0AOfVdUiu5tWeMF6KGle7zoGq0MKY
	9gGf+ycb0grWRClhFi+163qb2DeefKSXEo68kodeZokwhhEZwFKH5U4fCB3Zp+cc
	R9nYI/V0H+lb+wbn1oiqWNv+ySr0cbbQq+nUvODlfPQEFwJ1AS7d4nXhU3VqNpq5
	EtpYwDFR4T/VvIopOv25Q==
X-ME-Sender: <xms:WLW8atJuoxJltFboIhLWYMnFe7kSOfnSUJrDxBwz_ykxo9IcvmpQ6Q>
    <xme:WLW8aj-vTeZ03hFY3-Xg47_ZCI_AT7cHj1dMzqR1YUyX-o7qzm25EeaAKKxze5OAO
    MjvtjU5yrEJy1ivuAeZlnjw4TPCmngJVzEJ6IMLT5bphIw3iaBo9Nuw>
X-ME-Proxy-Cause: dmFkZTE/qmoaW/yaevqpZlFLiOkHibAY/OhomJ39Nf0lZl2LXlicP6VAHpSHvBtP2roPJ7
    I/ibhAj5LlO2zGUAttDQSH1Hvlptb+IEGQoNDQVsQBFpbyw8yazf5V6Z/xUHUF7z1JUTVG
    EU8nZqgzK0HOoikbQ6GCZnT1r0KAwGAcCDJSgk2GEaVD51x2rgh+4UK1ad7sFLSoRPoUzK
    3Th8oQ4hyYBwX5SfJNVI+6a0qRTJzv7JJvfrCs8nq9CSHd/flqeSHIh0qWhDJcE/6XS9XQ
    Ig+lGaYCwxdDcBy6hX8F18j7BfE0YukAB2Vuqp/418793tCwmvdoGDfTMUNHrsyLkknSqQ
    CG2AgU9lihaL/N6UPhqQmdwCxJJNYO4JuTcuJOWqq4FtO4NFf6AGATzvgT5VgP2cvr3gok
    oZYjlOvm2mVQ06P2wPmHs2iGEe2/Hadlgerxsbt5Ytv6trRItDVV1sqmPlomfVGds8BfGL
    Iglk73Wr0xMmmz4kAEiheo5SvsSmBN/pKHF22GItBqV7SmtsnEASTfjuyYzw2wBq/UQ1f9
    wHqqxMqzipcyXDaI/CBh+PELKLXX13Sk7KxPnl5ws9vnH5xSzL+yo1llic7NVryFt0y1xF
    tWQBvBbl5mqqA8xa+tAc1AsAntBeddL5xh+898ff9FcqHf5JZ9JiwCHoZj3w
X-ME-Proxy: <xmx:W7W8aj7Lo2klBcwdNO6_2YbO7MbJSY-yG0726-7b-qQNwYtqPB3Syw>
    <xmx:W7W8auqFy3dXrh00WfEh9fYfmMHozZL_gP5TsBT-5nTgt8I-1mxxcA>
    <xmx:W7W8aoiPsxcBdnMFUombFp_2-qIVnDwPrGHRdTCTB3WfMybG9URMcw>
    <xmx:W7W8ausz3LSz1C_d5Tt6_-VTTdSEGp4etmpEpQeya7WEI6G0FTfNCA>
    <xmx:XbW8avcIOhfYmTeCA8Uq2u4tevvyoxP7CeAZJwGaY3z5m98VB7XfqB8z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id BFAB032A008A; Wed, 30 Sep 2026 03:08:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwqD3_Df3fEc
Date: Wed, 30 Sep 2026 09:07:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Paul E. McKenney" <paulmck@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Frederic Weisbecker" <frederic@kernel.org>,
 "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Josh Triplett" <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>,
 "Lai Jiangshan" <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 "Thomas Gleixner" <tglx@kernel.org>, "Tejun Heo" <tj@kernel.org>,
 "Andrea Righi" <arighi@nvidia.com>,
 "Cheng-Yang Chou" <yphbchou0911@gmail.com>,
 "Gustavo Luiz Duarte" <gustavold@gmail.com>,
 "Kunwu Chan" <kunwu.chan@gmail.com>, rcu <rcu@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <b00b3c05-2faf-40fa-a978-7d7f35db47b9@app.fastmail.com>
In-Reply-To: <21dd141a-03d7-49e6-a83b-f4dda898cedf@paulmck-laptop>
References: <20260925133922.1356404-1-arnd@kernel.org>
 <21dd141a-03d7-49e6-a83b-f4dda898cedf@paulmck-laptop>
Subject: Re: [PATCH] rcu: include rtmutex_common.h in tree_stall.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 29, 2026, at 23:07, Paul E. McKenney wrote:
> On Fri, Sep 25, 2026 at 03:39:04PM +0200, Arnd Bergmann wrote:
>
> Good catch, and thank you!!!
>
> What I am going to do in the name of bisectability is to merge this into
> the commit that added that call to rt_mutex_owner(), which attribution:
>
> 1eccf02fb8d5 ("rcu: Add running and boosted indications to RCU task stall dump")

Sounds good to me. Don't worry too much about attribution, you can always
treat my oneline fixes as bug reports. I just try to make it easy to apply
as-is in case you are not rebasing your patches.

    Arnd
