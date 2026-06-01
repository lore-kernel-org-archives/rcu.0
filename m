Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AFF3431E3
	for <rcu@vger.kernel.org>; Mon,  1 Jun 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306195; cv=pass; b=GonQsNBgwE9hAdGopBoyn/NngYnEMqXvWRlSVU8/HpIO3chgvn2soVLR7HFnpC18tahE8G2YJKEQBMO3xpSPX1ROTq1+wCRwiUXjzKlT0fTiHPWazUYgW4qRlipC4bmJ6/oRvuRJu3h5FToRWKnE5jVv9wQk65wuhgKbs+NZIXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306195; c=relaxed/simple;
	bh=vzmgYrH/xoIGSOJF2VoBKhNMWBPHak++BwjBPknRZNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YUbeh4Ykidk+3TXA4/PXWjCL1AWPRfR30QHdo+ohGrgWATO636YiOGawucKBPkx2nkePGkwgOkg9OryOdJ0LPChzO3+U5P3TkKqC51kpj8smOYfycz3TzfqxhZPGzrF2ihMR0kpCL3y0zvDQi3CfxlVEMjUEDfaLmF4YukL+/hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hatc6Ufs; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hatc6Ufs"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-304e86ecebfso340175eec.0
        for <rcu@vger.kernel.org>; Mon, 01 Jun 2026 02:29:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780306193; cv=none;
        d=google.com; s=arc-20240605;
        b=PwZV6UmGq1HolHXdUuNsf0o1LhMYaLVHKyfGxFAxNBagOjcwybnpVTzmTnybXP/4lM
         NbvbJtSziGwVnE3IijWt1QW3dWFgRvS1zKw+3/Nl84FrY8XP4KvgqIhYfpOmZv4RzKuQ
         xmh8Lk99lock/7Ly1sF62Ee/qhJkn9sRe9Ra2CS9yfAszoaa36fs853ufOggdzy30O3t
         wAVuzCZ5us4B3SQdtcDVOl0wFVaw/v9Ec8dWHQKPzikBIeisn9IRBnqtLzXn4+upAwmo
         ngOCfQDcH5uOeQQ2/G/d0PB9MHx204GmyfH2vvg+Vhq5lMKxfFHq4zcDw5jr9xjQDN/v
         2WcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vzmgYrH/xoIGSOJF2VoBKhNMWBPHak++BwjBPknRZNM=;
        fh=r1ot1piMBEl3F2YzrbBhlfphm3F1BBuqNcJUzlI+Vds=;
        b=jL/lDUa1L6LT1zf3i0bxrR4HYoKTp0ZrS27d+zPVFXpuVYKi20yvIXCSuQ24z+gs96
         f2AwxHveoiiSx2QTt5ejJTIQzMpzRmtPKCJSJCdBKFOxFRkq3MGMgXekXW/xdO6UN+0Q
         dvBElRBQQwAJTbOwRNE/dx2MQFDOL/+L2Jteec/fcMxI7tZPbBmunGuPzY//iewuzwA4
         fdS6bb56FjjSndA1SPDWqRwtxgHeYpnnYVPvfqDXinzS62KDXiHkUGoqq+2l6fWkNqUf
         UufzQCCCAAWp4aP/YX6Owp5PzKPN2TBMbxizx7NUxPDANKILHt2ISAuSbKZSGduah1YE
         YDlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780306193; x=1780910993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vzmgYrH/xoIGSOJF2VoBKhNMWBPHak++BwjBPknRZNM=;
        b=Hatc6UfsIcjyBL+5xNRg52HiRr/00LIRDlEPa9zELl87bix8AcS1Y0DVMSQ5RpGLQj
         PjOErTITxmg/IfPJDKuzjn590G7kQeWpsZdyVxNGQ2cAgUxigRnY33djDr1O2HAohXr6
         0eaM6Ip8/LZRT2gP8dHV2pROa40efY6llNhVcJjkTWWpTccfKV+/yJY/lR6qVnIhTCoI
         r9r4nMWa57OkQso6KI4u6VNMbCLJJKGYXs2L+rLU3A6ICygzgMt5rpHeTbrhgYn1RjOP
         /Dbpbn2Q0hn+kt+GZU0cS8wDwZn4oQGgPF8OODeZetgEfKTDqPr1rkMZDc+Gcsa1nWGn
         lznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780306193; x=1780910993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vzmgYrH/xoIGSOJF2VoBKhNMWBPHak++BwjBPknRZNM=;
        b=gy3yxCUE9l/I3sIh6cVmmWMTCLWHjbNIJniSCCf7D0qPWmRlocNWLTudtmw0npzjbR
         vzkoIhwoVejux556ren1zjunUveWYOQYGYcjiHPk3lJV92tNlOhcjc7Z2QFwFsDcHB63
         pJ047zTbK2Sm+j/knScoC5hnk7i1RDWG6cl5z4aMZ1uEb/uW/+ZXGEcSuD1BXKXLbMNW
         eFtF1SYGaSsuu5s2kMULOLl03SdK/1lojhAzMiu1kSIWiJt01Y+PBZy8MZwH2VaY1kBP
         dbqqq5bnE+4EhmAjDw/6K0QU+FgHG60wmoM6CglnGCUHuhiQHfzoaLXE9D14f8o9PRrP
         6/Gw==
X-Forwarded-Encrypted: i=1; AFNElJ+tS2MOgUnQqvNar6Gl7alt3hjiDZNIJnFlmCAosO5vP5ziYS6VR48Lht/MKaTBUbS2JfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzppmK2DdOPkAz7LCGC8Uw0aRpcvJItGMkSzL58d/QDaVjeXkhW
	MpXMEzhzPtMLW1HBH99voCh8X6qstBfNvK/bGmw1cjEcGb06QY74kvdrETSQ3ENKRgXda7PgbNq
	eTMlNuRzPFy4eQ851Wqj9/U9ey+yNOLs=
X-Gm-Gg: Acq92OFHDCs1b/uXliLtt9zoIxmJ/f+TNaKGBm7+qcQOhLwHXHpkg7CvmXjBCSpIs5v
	mhVde4Q38S1Q1jTUclGYaOaCFsw4qQzYe2U8e2q1iLtxkBqaX0DmNKq01V7IKHQbfWodRAlVqdB
	jZoP9YeOSGaPdkL6hDl6pVBNVRtuyrHdYutHcXolwFoy7gqpV2/ecYpTNrMgpopLsOCrno35i4O
	P5iqB3Z60bGF6oss1OehjQaOQysAiI1oG+z/qygYlU8dDfGBq6G/nkMeCxXIzntKllA1bnR66Gr
	CN/Int4+Gnq3MnH6cmF2NxMl+omSsl37+ELpSSgDf2TSO7KLNy6Tf4CV4d4lyufgS7pLzLPc8kC
	uvlXwJiw4qIEzDkkQ0uR5b8KpkwoJXAhW6Q==
X-Received: by 2002:a05:693c:2c86:b0:304:f860:3ae3 with SMTP id
 5a478bee46e88-304fa49e500mr2410100eec.1.1780306193421; Mon, 01 Jun 2026
 02:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528062810.256212-1-work@onurozkan.dev> <20260528062810.256212-4-work@onurozkan.dev>
 <20260528082025.44414-1-work@onurozkan.dev> <20260528083518.66203-1-work@onurozkan.dev>
 <DIUB2DNTF6W9.2BT1NF6UXUOFI@garyguo.net> <b4f6d3e8-3a08-409e-89ae-ba5d612bae30@paulmck-laptop>
 <20260530062730.38077-1-work@onurozkan.dev> <3ef86db1-edc4-4e50-8614-2dd7270540b4@paulmck-laptop>
 <CANiq72=jVHEu5veW_k9B66avYgVR2aHDN2QmDny=j4EK2uRXbw@mail.gmail.com> <20260531191107.35357-1-work@onurozkan.dev>
In-Reply-To: <20260531191107.35357-1-work@onurozkan.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Jun 2026 11:29:40 +0200
X-Gm-Features: AVHnY4KMlWZQ5dbcCfvIubv8U6IPy9fVqBTgRvMlZMsUSNcKgbQp1EdWOYSjF0U
Message-ID: <CANiq72mdeiG79tS4=xbCzHT-n5ZDTB5_QKwhF3Z=XeuWkr8BXw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] rust: sync: add SRCU abstraction
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: paulmck@kernel.org, Gary Guo <gary@garyguo.net>, rcu@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, dakr@kernel.org, peterz@infradead.org, 
	fujita.tomonori@gmail.com, tamird@kernel.org, jiangshanlai@gmail.com, 
	josh@joshtriplett.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 11:17=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.dev=
> wrote:
>
> I am waiting for the v9 [1] reviews. If we get a complain on the current
> approach we can consider the Rust-specific clean-up C function +
> disallowed_methods from Clippy.

Just to clarify, I only meant to reply to Paul about linting in Rust
in general, i.e. I didn't mean to ask for a particular approach here.

Cheers,
Miguel
