Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1C1494A8
	for <rcu@vger.kernel.org>; Fri, 19 Jun 2026 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853590; cv=pass; b=e0sK/c/KEsjwUJ1bzzB+dWT5uYu/P9Scv5k97WoH9/XHuahn/EwvPIto4O4aueZIEQJZ5B4Y/5YVdTyGBH/kJdC4jHaJEXSLyFWPDDFkxjj7aibKyJe6syhcRPaSao/4F848bCKOjTVblWumXVA062mMfWb5htPUyJMuB2F9vtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853590; c=relaxed/simple;
	bh=+88pK79ZKow9Fb9mNlK3YIEu6a/K2Bzmh7PdNNd4HV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym/rLAjL0IcQPJ1KurF8Q3jk5bdKU5ZSkDmMQNgVfrPsBfr29HRv9rCC9R6KHZS/ZFoBdcycuSLSD+W+oOffoAm0DhJSy5HvLRt45PKLElvI1gVZu3qkPJ9/io1p+SV4XdBwlpsnJ65NgZLuuj5O/FRkK32DOKmYyVD9FB5eLWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKQ02m1S; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKQ02m1S"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30c0b23993eso25885eec.0
        for <rcu@vger.kernel.org>; Fri, 19 Jun 2026 00:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781853589; cv=none;
        d=google.com; s=arc-20240605;
        b=YyBUwO6gd8LulcqDHCKUxZfx/YY6n6olOTnMCGypcMprpRSr2SGM35gG9uKnlTZNt/
         fsrWEYUcEIi8V8nOqST4Qh+cgz4pVMCYGjn+gMMyR+b5g34/CuyN3MLiMRbdl2U3j0kZ
         WuyTOWrrJ8Jc+gT8YJXFtJ0+2LjLfKoBfpD7OXm+pu3z9b/Eai4W+GmxOdc7wy/r5BoP
         vg5rsX5BbPOKdvxuhtBGlb1G6OgANFlsGvsK/t3JWy0beq7zXwIh9OZRuOtRtwG89hse
         K0M5XmSGRtVqUuLmcg6ounb3FfDyn1bSP5CqcVeNzLnS6sYvdLDN7HyKkXgexW7fMMQi
         QiBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+88pK79ZKow9Fb9mNlK3YIEu6a/K2Bzmh7PdNNd4HV0=;
        fh=rh1FFxTIufO9XCF10cehXY7Ty2LV+emFHhOy2NrgX9I=;
        b=BR1IyRwoIUOhaShQ4T9SbBA7Wta5Y/XoZVF8y5eUXGqLqc+8WpJzqxZ5Ku82KovGh6
         lnzO7AgM4zaMO7ucKQLGSbmUR4QdauQqedkA5x2yh72tC/ea/J260ovxbMy6q9uMUiVy
         ZSDE5zJQ4iRj+V5z5n+AKM3fderDBcTTyJ3uxfruaTg4K+XP0FXVMzfA03tKQr5qVRzT
         IhcHV+TvF+D690MGUoCbeHqlWoftn37leeYI/4q9n6rvhOk66Kc9yi/AcTB7pDSMZSa9
         PQPWZ6p3OZ/g3Tmu/Oj4JcDJt27zrK3++ka9//8PSOlIIGOEIgn23ZpNTB3mpV3LGKZB
         AUmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781853589; x=1782458389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+88pK79ZKow9Fb9mNlK3YIEu6a/K2Bzmh7PdNNd4HV0=;
        b=eKQ02m1Sq0SOnDgkLzDbAnMZBwm0XzXFwHJL7PwP7fzF8HoTl+pdrl1h16JPyU0KbV
         /2TnY4O9qU1U6AJmMmgU6hJVc56jWip+JZj73R5uXQm7Cr/2xzymbRGuY9gc2A+XQ01n
         5zAVIsNVedDFi6DAX6BYx3Ior3k3DUdxycvlrWNdjajfuseX+R4mc1RBOMk6+7A7P+8Q
         RsY3qYnvKH+MfhR7SG+frWECLfoMMARjG8EckplBNVeYxM9/8Fmm0c0fPIINSmS2f7g4
         r0sl9F6CrVusoG54fJwhlYBkTGwbCbHt0mLN7Z+V6ZHkRn95Jap2vPAS+mmJic5NpPL2
         m3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781853589; x=1782458389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+88pK79ZKow9Fb9mNlK3YIEu6a/K2Bzmh7PdNNd4HV0=;
        b=A2JHHdmGXBcO5p3GEqT6jfi1e/MNk7TE7q7mCkqxJDSCaK2/oGx793dbkPOBkpyu+B
         TnricIMJTTvTO3RpnG7eThqNocGSPIoOw09E/pt6RBVBD3N325E9paMSzvDH2juEX8JT
         dzIooh1GjI++ZpUZOOB6BJ1EHiPorEfr0dW45qTNcAJRi9SY1a/CmtqFhmqL+GQI5M0Z
         O7OnILSHEXIYahEvUCQFWD4LOetx805u7eYulFr3fOzmr0Rov5KHp8zNi7tmaq9RzyP+
         YgoedyjICNpoibu7hR0AayDbtzaCFx1cX0NVHz7jDtRg3URMApdQ40Gt8uzGeMgi33yZ
         vf/w==
X-Forwarded-Encrypted: i=1; AFNElJ8preEc3FG0P7F2oithcOAut6YEmTAJoRhZ8/sHrsU50b5FxxEhoqn5i/f6gzJ5umExRH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0m52kCRELxAQtgVaDDHz2WduG2YVW3oybMFGYbpS9lp00BcpL
	tJvpHt0/Jt5NUSqgpJwL1BIbNSyiK1c4kHbRDxSeCdGLPp79WgTpX8kMXf0k/5jUD9CXtovG9bi
	0H3BeC5uAwzwuLk1ciTPSIoy8PPOznoA=
X-Gm-Gg: AfdE7cnNqvHLyEitMJZiRlzJShbJlg5qCCasPdQcF40LC7JX5hPnskC+vP4tFydOMb/
	DOl1zp/lQ0QIL9loZ5NIXo4fWIO5nPS5PdTqWMfgcCIlU/LwPXUyXZWmVyCFkPN4M5hBU2fjns+
	5jMK6N9XuI4aqid6F8JvevKXEzDi5c8U4mKPZHGt+tHeAO9uRCyRK3b+lSbCpsBqWqx0GcB01sr
	z82OT2fRaHAZsOc8b+q3m1Gp93TqVHkdOigUKL0j5DedUdFe/Pp7qiI2dsPICvQQu/whh0jXNNB
	tDVrQ9Td3XgT1T+DR8adyjwYeR1XbMqrTCVsRuGtWc8tXr2nNWairEF8CuVAsoXQfEYe1tfKQq/
	rfTHIChprnkAS
X-Received: by 2002:a05:7300:5b89:b0:30b:6192:5b9 with SMTP id
 5a478bee46e88-30c0704c252mr782252eec.8.1781853588746; Fri, 19 Jun 2026
 00:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-4-phasta@kernel.org>
 <20260618181142.200117-1-work@onurozkan.dev> <c449f26e2283a2df6d5240879f85bee1b2fd4c50.camel@mailbox.org>
In-Reply-To: <c449f26e2283a2df6d5240879f85bee1b2fd4c50.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 19 Jun 2026 09:19:36 +0200
X-Gm-Features: AVVi8CccBt9yDewoCAnVIMsVlxtHnVavxuQfjS-nEO1450uuf_IE5qGPi-jNBGI
Message-ID: <CANiq72=HzRRMNZcNfpZBPmefo=LJ2ckSk=gQS2=XjgnRQCkjRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
To: phasta@kernel.org
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lyude Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Christian Schrefl <chrisi.schrefl@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 8:56=E2=80=AFAM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> Was already like that when I came here ;)
>
> But if it helps I can format it while I'm at it..

Yeah, we are trying to clean them as updates happen to them, i.e. to
avoid adding new ones in the old style.

Cheers,
Miguel
