Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF1377034
	for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210291; cv=pass; b=tDdCGoLwoGNwyN3mH7rif7k1rI4VnlpcKVofJIGgENvwzGMLaoOCqPmSMoHw78Y/CgqDt+jqEHzOkHb/yYej1mfZNZQB3Axm+H7J+OZUUpm2MNZlAlPdqkCRDCRcqwm1BXCvUPj6Uh0Tu8JNgJ9/l8ITVlszlwRNLR6GVbDwx3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210291; c=relaxed/simple;
	bh=8p1PEq/JYxMhAtp/eLRUsGxj+TLfc2A0VTM0mSMnb54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bwV3YrSoPxR6teLMfOtRA/T6UloVRXWDTCnoowPHBCqTEJKvbq8hEPD9BUjXeBHElswEDcaUZ7ybsKeN41DS3hdO9xLYJzmlPUifWtyj7MlC9L3JceSuBDMfv2nF90Y3icVczSNok4IQ6Dnn0hnDf9XdqG35jAHvIOQz+iV/ktI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMESXyeN; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMESXyeN"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137e836ccc8so82402c88.2
        for <rcu@vger.kernel.org>; Tue, 23 Jun 2026 03:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782210289; cv=none;
        d=google.com; s=arc-20240605;
        b=FtrHzoEFHhF86B7RLZ1+Kk+sYukXfmyi4h8hIfxMM1cMWchbzfL68+qF6rhjf51cpY
         THOlAXRrRLew0PwjAUtN1WJMO3Yr6e0WQJAXeeAjSFHbwupEIy1MYmO8uLyA+CGdJV0Y
         XnXJKr2wR1Jq9HvkUhlMEewm+7mIG3/rtCKhczlXniyqSRIMdPV4SnQ1UCHh0/lp2MJS
         0WcpUt32puGIGZFiGC/jrnnadiKGEjAOA+q0xzVGF0X1O6+6qIVqi10zJWNZDLQpdNYZ
         He/qewp+CYejflzGeH4IKZcNyb4pe7Sd8gO5ZIb+ysg+YqXLC1qPO+Z5VFrYdhqcow8c
         3W3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8p1PEq/JYxMhAtp/eLRUsGxj+TLfc2A0VTM0mSMnb54=;
        fh=ZcAObm9fUDV3HnqPTHBCrKK9PYxuAf9d0K2pfMxZ9P4=;
        b=QfboQD/OwkJoOLW5tLWAOW/I8qSfnYkvKXw8BKKscbaw0imMikuK2+jDq3ALCwCKXm
         V6sne27JdIfS01GXCxPTgG7g5mchvDf4NmzXTLf3oqh83Trt2i0jrR0dZ7TMrORdnvCa
         HeTP9adUaNlNfecdYWN5/uYjcHDJjKzqrG9zH4s+yXnWsVzwGXrrB6tG96TbxHX4Ka5T
         g/t0efUDX28qTqWL7d+B9kkDMguSEyB5vuNWzWmXx0lkWvC73eI4o5WwL3h15ru3NhxZ
         3Kc7Wi9qkk6vTzk8wJO6f5RNSKnWuJu2Six/rEd4Yj3hHrVuTzg/LLaw2kM+aJqSzRHk
         WutQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782210289; x=1782815089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8p1PEq/JYxMhAtp/eLRUsGxj+TLfc2A0VTM0mSMnb54=;
        b=bMESXyeNF0Zp/XsKh3MwjSJhwW5ULG0eYUYI8gxlbpLxVlc6AvWtovnjDAzztENYCK
         YkO9Zz4jr1nXkKvC2V8xXXotlKuQITNJQKjmP+GbFkTV5HPk2eDAK+gcDphC/Bzd5eHk
         uvH2pSck5hk2TScke8/Px6+Xz1LGEGjUda1fuxwiJzwUmWWBTPgu33Q2jE/qOycfFbhs
         yRpkp4QvHDXOfk3XvOzP1LQsYwrRrdCJCg45TpMqcJO2CQ9SiX1Z1CZxBJvl4+6nTELk
         RC43psHYYDCAD41DGmmtw+TzvVnacBT2drD70QuGuXHQMgEj1HlOe/sJHWX5Ch0k/e0U
         BGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782210289; x=1782815089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8p1PEq/JYxMhAtp/eLRUsGxj+TLfc2A0VTM0mSMnb54=;
        b=YWXo5esM7LDcBR//gAVq4/52Ete7Vyy/9Qks2+edjnmn0ndryNQGAFuIWbvefMg50K
         it7Clxf936UYdNIMsCG3xzhIv7hRx6zMd+/H8NQEyUWMDTz6WriGnbR7j82zahOXGTwj
         sPiPSkfEEoMq65VxxfmA27xejBbyaM1vJrgl9iHSdSA8Wti/erbj+ZvuZAUwO3shhPS+
         dR6pPwsnf4Y2R7Zg48Bu5yBpn+MB3m0FVyiLCMVSQ+J6gB/Ynjo7NR+e5RehS5+RV1N8
         +TJCutC/s+KoJaioZa6GM+3cyyeeGGNq9SmbLzhBT94okrNCnTj1IGftieZQeVmBvqcX
         FZAA==
X-Forwarded-Encrypted: i=1; AHgh+RqpF5ojoL9ezTI9d6QbD72g+SYg9Qpg181ITaH0aNbmBHWY3wlQdkbCR0tCtIR1o+8tWlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/gEEuxa4qcBgYgPTehKdIAYReh97MrUCOApCuYcuUqkvN6Vb
	J8cnwfJtsewJgrnrWmBq84FixPBf7pEbPxM43WasZqPe5aQj44PPkruqhEowLg0A0gLVtJ4s9ZD
	njDhowRnjp/zT3Rp1m+GIHXFkdnE4S/E=
X-Gm-Gg: AfdE7cnmQFb11mJpHNQxJBjIZPF4vENIDYYDJ77I+mBdPQbXWyc5ywpFYhqSBnVOyZn
	d2JKRMWfT2vtTVSSfyjG1zM0o/rY7R85SKydUpT/ZzdfcK7UUDWiIP9LZQEb3Dg9A94cLBMJncb
	fx/zu/wSUaj0dwnkAPL5Pu/4g2sr+n1VB6/PI9ousxj3FlwFhar/iOmdHPUEc/OVwjd3vQGsoLb
	jsu0vNDgko6tsLjQxsfnVUJrF9pQHeLkI9CBnTO/kIrvVzQ0ZMErd7eWiwb1vhkcH6He3ttwLTj
	p39N+IZ0obyb2zNWgpLAQVh2neoaX653naxKabcyYLfgus/DMP1YTLZiCI0Otg39nsr4vGBf9lT
	vdkLG7BgcwU4F
X-Received: by 2002:a05:7300:7494:b0:30c:52ab:806 with SMTP id
 5a478bee46e88-30c52ab0c05mr1446569eec.4.1782210289441; Tue, 23 Jun 2026
 03:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622173250.411377-2-phasta@kernel.org> <20260622173250.411377-3-phasta@kernel.org>
 <ajpJmjTST-Hoxutb@pedro-suse.lan> <908762cb7fd90df1df70eda28363a0015c404527.camel@mailbox.org>
In-Reply-To: <908762cb7fd90df1df70eda28363a0015c404527.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 23 Jun 2026 12:24:35 +0200
X-Gm-Features: AVVi8Cc8Kh7AOr5aHxP44CbB_NUQ2aQAJElI3bwSmo3owcnjAf5xJcUIaFT10lM
Message-ID: <CANiq72knGU+PUCXUATOkA7225++0nvALNByoJa8gaV_EuyHx6g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: sync: Add abstraction for synchronize_rcu()
To: phasta@kernel.org, Gary Guo <gary@garyguo.net>
Cc: Pedro Falcato <pfalcato@suse.de>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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

On Tue, Jun 23, 2026 at 11:49=E2=80=AFAM Philipp Stanner <phasta@mailbox.or=
g> wrote:
>
> But it would be interesting to know more about how in general Rust's
> unsafe comments are related to problems beyond UAF issues, and to what
> degree we want to document context requirements.

I am confused by the UAF there. Did you mean UB?

Rust's `unsafe` is about way more than just use-after-free -- it is
about all potential undefined behavior.

At the same time, it is not about merely "dangerous" things.

If you cannot possibly cause UB, then it is not in scope. Otherwise,
it is very much in scope and the safety preconditions/requirements
need to be clearly documented (`# Safety`) or justified (`//
SAFETY:`).

Now, sometimes it may not make a lot of sense to duplicate a ton of
information, so sometimes we lift text to the Rust module docs and
refer to it; and sometimes it may also make more sense to refer to
external docs. One way or another, the goal is to document the
requirements and what is going on as clearly as possible.

Cheers,
Miguel
