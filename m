Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF53345CD0
	for <rcu@vger.kernel.org>; Fri, 10 Jul 2026 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693117; cv=none; b=Ixyn755wXxjUNut6+CorIPy5T1LliVkAHTLWNDoKs4ZcuglNJK8s/P0Vs3rT6jWYiGQg5XZc+TW+Nsb3Ff5KoYi8M7DbZF24WkOM1awsCWHMwVnW7QnsMvCYUod+Zu6JdK1Fhzk3MuRIYVhNPg5Z5GennxIslfXWImN5JzmL5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693117; c=relaxed/simple;
	bh=h0ZHVwtZTiRP7yqcWynLTJtYUs11TVD7AoQ0i4aDS/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQiY/Nhi4vlJ+PNrcsCELTQNu4RhNEolcPIXmiPRZXekg+5E9TOLrt17+vxaftBdm5frz+NLNTQ2vyEpCFEn2TgfWrqFBPx1gmLaf0iiTTRImX+KUULVtpmtpomHHCPdceN9X9AJMAKh1+2Q7/QQ2Uz4t6ipIoxRiYWgfBdF624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc1rBGlT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc1rBGlT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EA21F00A3D;
	Fri, 10 Jul 2026 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693116;
	bh=bSRmUgWit7GTVsObfJTPFP8e7Ob/QiiiJf34QzGQCVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kc1rBGlTFrlitgmg8jM8JEld2hMWvp3ZvXojg0CELDeN9tX4QG/JSkueAW58nDE3V
	 SEPAM4r6gKJRFbqqhK7WY4y+PzD4fveh3Qzs3Mic/D5Rrn/O9up4gCVjw5SN0dbSim
	 6zqNy/gz/G/oXwfHR6xhHsBNJkVGKQbkC0psAv4Ff9uAVlZk6hJU8I6E9wk6geNAOf
	 KDg9+/Ialk1haJn2SblIFaECYJHIhQ8VHX+TFDdU2KJ7BJ0tePDrhTSl8X9knRdXWg
	 iGiVSHvy3W8FR7ghidcEzsLjM7DcXPHllUdObYXYqk4qpoRr1jKEGSbAzRInenZqSq
	 Ytt8KgjFth0Tw==
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9374DF4022A;
	Fri, 10 Jul 2026 10:18:34 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 10 Jul 2026 10:18:34 -0400
X-ME-Sender: <xms:Ov9QakcetuQIKWrrmd5MAVWN65lmsfIHQEEvRgN78ixBcLRCKOKLjA>
    <xme:Ov9QatREjjzGbmFGtFkE5ZkFceTUGBIvrM2jy_QeMKSgRjsUxTb-1EfHqmr8iVRPk
    PfAsN3LF3HePolFK8J_8bKxtuSwzMQO8CouqRjhqm3uRQpDFRW_>
X-ME-Received: <xmr:Ov9QatPno-9rceu3-RdiI1Vg-z0-3gFTTztPtR5RZWKWMIJb2xLXs4B1mfLkA7mGmQe0rhwTZ9mzMu0gGedeJQypX0PGqwQm>
X-ME-Proxy-Cause: dmFkZTEe8wgoPzxtGJP2X9SR1vbWgM9iLGJOcM8BqJtrXVRNcDmnRDuLPiM4EYKEK9jz0d
    anWZeb6tXv+HYmGQCwkDWKceI2+QrjtvK5Aixq2JgVurt0zM9tsEgtIiLlRXiaV4Kd6FKQ
    x2z7en+/Feai1iRKymcAnLyq9vzWzdHHvoOKJxPF/+pfP3mcyERrJeixLo2x8Cu7Zcq5MK
    nEGiYxD/LbJLQCrjQXZX2w6ZMyjLbwfF9z+AZ/z7pbcmO0IAWI6CvrI9IZyZz7eV+GBIq7
    i9h/BaBDKKalqvHPLO+0/KDqplwhhzvYuLgTaEdMt/rsFoxnY9YoQk4DElesYTeW/UWHYf
    klff6rhS03+N3S7bcycj724J2ufjChN7IY4Is7kw6SeCiDg4dNKcCWTw2UmF5swfnFpDSR
    wGwqdmQjswl8cIcfspOev++em82qRWP5ZsU1TUEDWQwNgWyjoSQzuOg644w8IdbF+tTfVt
    c/+c6l0oSx1wbU1avYdrdqLNONyuth9va3kTeKJA03RTvaju3CHf0dKBbA43vUfmd1sdEd
    7rG/ELFiKOXtyeNPzSJ+p3/3bfEsxOmdALMReCZbBqC0bRNL6x1gmWJxNCkvBXdE40JMBI
    G1sm5cJC0aDEZaUreFzC46JNugQXiKl0eY1RjCMa1wqrlkX1PT6ehptu0U4A
X-ME-Proxy: <xmx:Ov9QagX7o8WH5M6zzp6uemlhVPd7OgNo24_J2ZZnzzOlxE4OOS8G3w>
    <xmx:Ov9QatZsrrcaxCCFWRT4jP3-jZoQuN9FMdF6R-lQmTheHKEja4UaTQ>
    <xmx:Ov9QaltMJnKqTEtIfeEZuXAggvSboSrcn6vf0FQScvhYRpgrOm0FnQ>
    <xmx:Ov9QaklJ--u61KkOie5DBJKjJgahQSL2VIULXI7BJD7RpCGewgAb1g>
    <xmx:Ov9QauVx3cXOXZx-xaELxlf-oHnSCVhciJu100YuTv9c8VFLf-PwcvOI>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 10:18:33 -0400 (EDT)
Date: Fri, 10 Jul 2026 07:18:32 -0700
From: Boqun Feng <boqun@kernel.org>
To: Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>
Cc: rcu@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
	peterz@infradead.org, fujita.tomonori@gmail.com, tamird@kernel.org,
	jiangshanlai@gmail.com, paulmck@kernel.org, josh@joshtriplett.org,
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v10 0/5] rust: add SRCU abstraction
Message-ID: <alD_OFVyGv7Wesq0@tardis.local>
References: <20260613065348.96750-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260613065348.96750-1-work@onurozkan.dev>

On Sat, Jun 13, 2026 at 09:40:06AM +0300, Onur Özkan wrote:
> The immediate motivation is the Tyr reset infrastructure [1] which needs
> to serialize reset sensitive hardware access against reset and teardown
> paths. That reset series started to require many independent dependencies
> so this SRCU support is split out as a standalone Rust API to keep the
> reset series focused on the reset logic and easier to review, rebase and
> land.
> 
[...]

Thank you all!

Reviewed-by: Boqun Feng <boqun@kernel.org>

Paul, per our previous discussion, I think this series should into rcu
tree, since it changes a significant part of SRCU C code. Thanks!

Regards,
Boqun
