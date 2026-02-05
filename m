Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377D32ED4C;
	Thu,  5 Feb 2026 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770324455; cv=none; b=ETtJJ0+pnm4x3D4hFSxR/ete1ZFuf3JU04mD8Gz8jN9b/LJxf1xkPufctM4cgAQmesUgt6EtONkUlFukfHZQmlZzMj3l75ZR1fBwqEWP/oXURxuVDh4vdJqTrz6nyI6pe34+lXRzdG0yC+sS7GHAzXHs4jkLrDupqrZqwuQ31Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770324455; c=relaxed/simple;
	bh=pO1+JThAn5iZkSDpLqtojlcBZvNK+oO5Xc60Wz/ZvII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4GSAz3g7OXP5C5QCS7Ro/ZAdTEXC8FdSnrKXxwqdsCrU4OgrprST2M8M9KI7u1wCo00F3AsEjSgyA/1NxMvlAgXOQc9gqN/nM3kAPuMb8H7msFYo2C87SNolJqMKHti38na8bi69X9UmRNOgoQ4RpZ9O/xohp1Srgq40iORDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIIwdsxz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIIwdsxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B57C4AF0B;
	Thu,  5 Feb 2026 20:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770324454;
	bh=pO1+JThAn5iZkSDpLqtojlcBZvNK+oO5Xc60Wz/ZvII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIIwdsxzUtgsI1d+VsTVCrdregqbbmiH3Z2TO/SK7CZrSF3Ca/qrcNSegs0uUoAVc
	 cf5QnPCkA3N6uBsqK+PpxqvH9WqabTqzJpu00bEPf011/qLvpysuVPHQhnEH5sjdMp
	 ymXPJu5KUSGE/NxoXzYK8kIrVPDdE51A68a5nnj8jjzbkaY2TUK2WcICgCUVAdFsmy
	 jpaJOs6Bq7JVbdI5GxWhst5GUj1Qb6fOap+Fl7G/EvcZhTyBBCC4wgR2eAXHdGEjjt
	 M8oxoW3DsnjxCmyLQVDMeaQytF9Q9DLGsmoSF9IzPISovAGtpTFgnXWxwa7Ivjljbr
	 HUlK5zwnDvy0Q==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 78F8EF40068;
	Thu,  5 Feb 2026 15:47:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 05 Feb 2026 15:47:32 -0500
X-ME-Sender: <xms:5AGFaaKGxBWFW_gebcxuac2XW6TtvgVohe-e2YvIFqzoovv1AFew6Q>
    <xme:5AGFad0s_gOHrxbl1WXd8H1LisrKXvC6kD6XjCwA0cgK4EFvb5Q6oFD7iJzZA7v0H
    lEeQkcNE10sKnguiwCvicAn0b-v9jcfl7W4f_A_Lc1_RRDPo_LqkEo>
X-ME-Received: <xmr:5AGFaeVFf8tBpjeEcPZmjsqOIJO5FaGwwIzJeVN71SYrXDBKJ-EHb-4vx8Ajn1HkpUb12M9rMlfgJ66riZ7bUIN4BOv8rD4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeifedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    efleejffeiteejteevffdtudelieffieeileekvedvhefhgeeftdefvddvieeludenucff
    ohhmrghinhepughotghsrdhrshdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsoh
    hquhhnpeepkhgvrhhnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
    ohepgeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhiesghgrrhihgh
    huohdrnhgvthdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthht
    oheprghrvhgvsegrnhgurhhoihgurdgtohhmpdhrtghpthhtohepthhkjhhoshesrghnug
    hrohhiugdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5AGFafpOGvAC95R6nCwdOiGvz7tqqtJ--321dJ4QV2mrEzX0LyWrkQ>
    <xmx:5AGFafaBxmOzLTxOLIpMNfM3Boy-JqC4otn8OafmIzQszbw8cqiIiQ>
    <xmx:5AGFaTD7PmztY09p4WtNWM6SNmqd9-CwKDV69NS1lm7omI6dB8FxEg>
    <xmx:5AGFaaGqTpg40RyFkN-09O9mFL6NX2wAC0EEVOfZ8k7QupEzS_fieA>
    <xmx:5AGFafxaFMXTgamJwFJAOvFrA5KhMB81KDdqA0JSaJyuVJ4BPG_M9vaO>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 15:47:31 -0500 (EST)
Date: Thu, 5 Feb 2026 12:47:29 -0800
From: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, rcu@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,	Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Tamir Duberstein <tamird@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Mitchell Levy <levymitchell0@gmail.com>,	David Gow <davidgow@google.com>,
 Peter Novak <seimun018r@gmail.com>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [RFC PATCH 0/7] Introduce HasField infrastructure
Message-ID: <aYUB4VcsSDyQxSt1@tardis.local>
References: <20260128215330.58410-1-boqun.feng@gmail.com>
 <DG68S0UN78BE.QUG4A0Y08XKN@garyguo.net>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DG68S0UN78BE.QUG4A0Y08XKN@garyguo.net>

On Wed, Feb 04, 2026 at 02:20:09PM +0000, Gary Guo wrote:
> On Wed Jan 28, 2026 at 9:53 PM GMT, Boqun Feng wrote:
> > Currently we have a few similar places where we use a `Has*` trait to
> > describe that a data structure has some types of field in it so that the
> > containing type can do something with it. There are also a `impl_has_*!`
> > macro to help implement the trait. While it's working, but it's less
> > ergonomic to me, especially considering the amount of the work we need
> > to do for something new (e.g. rcu_head).
> >
> > Therefore here is the effort to unify them into a proc-macro based
> > solution. `Field` and `HasField` traits are introduced to generify the
> > "Has A" relationship, and a derive macro `#[derive(HasField)]` is also
> > added to support automatically implementing `HasField` trait.
> >
> > This series convert a few users (Work, HrTimer) and introduce a new
> > `Field` type `RcuHead`. These improvements demonstrate how this
> > infrastructure can be used.
> >
> > Some future work is still needed: using `HasField` for `DelayedWork` and
> > `ListLink` is still missing. Also it's possible to clean up `HasWork`
> > trait as well.
> >
> > One known issue is that `#[derive(HasField)]` doesn't play alone with
> > `#[pin_data]` at the moment, for example:
> >
> >     #[derive(HasField)]
> >     #[pin_data]
> >     struct Foo { .. }
> >
> > works, but 
> >
> >     #[pin_data]
> >     #[derive(HasField)]
> >     struct Foo { .. }
> >
> > doesn't. Maybe it's by design or maybe something could be improved by
> > pin-init.
> >
> >
> > The patchset is based on today's rust/rust-next, top commit is:
> >
> > 	a7c013f77953 ('Merge patch series "refactor Rust proc macros with `syn`"')
> >
> > Regards,
> > Boqun
> 
> Hi Boqun,
> 
> Thanks for working on this.
> 
> You currently divide things into two traits, `Field<T>` which doesn't seem to be
> doing anything (actually, why does this need to exist at all?) and
> `HasField<T, F>` which defines all the field projection.
> 

Oh, you're right, I don't need `Field<T>` right now. In a certain point,
it was used to constrain all "field types" must be generic over their
container type. But it's not the case now (see RcuHead).

> For some prior art that attempts to have fields, e.g. my field-projection
> experiemnt crate
> 
>     https://docs.rs/field-projection
> 
> and Benno's work on field-representing-types in the Rust language, we opt to
> have a type to represent each field instead.
> 
> I think we should have a unified projection infrastructure in the kernel, for
> both intrusive data structure and I/O projection and others, so I think it's
> useful to have types representing fields (and projection in general, this could
> also extend to the `register!` macro). For clarity, let me refer to this as
> `field_of!(Base, foo)` and the trait is `Projection`.
> 

Yep, I actually have an example PR integrating that into workqueue:

	https://github.com/Rust-for-Linux/field-projection/pull/2

(of course `Work` in that case should be generic over the containing
type, but that's easy to fix)

I guess the next question is: will you and Benno be willing to port
field-projection into kernel source (and keep it aligned with the
language feature), so we can switch to that?

Regards,
Boqun

> With this infra, the `HasField` trait would simply looks like this:
> 
>     trait HasField<Base, FieldType> {
>         type Field: Projection<Base = Base, Type = FieldType>;
>     }
> 
> and the macro derive would generate something like
> 
>     impl HasField<MyStruct, Work<MyStruct>> {
>         type Field = field_of!(MyStruct, name_of_work_field);
>     }
> 
> Best,
> Gary
> 
[..]
