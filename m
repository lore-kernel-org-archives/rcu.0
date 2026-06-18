Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBF3546FF;
	Thu, 18 Jun 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806321; cv=none; b=GurBL9I+A8+gMCMfaJXcr03aiMxQSXtkmcxo3oEjBW7ZSJr6b9z8JgloE8/gfeyycP51LkDjE1GOcL/iLmkiiBlaRs1OCTL9THnuIgRtW/s8lRHdXRlCRXg0fAue97Mz6KSsOPAi3HqH5dmIVS59t1fLt6GKZ2PJgfRPf23OQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806321; c=relaxed/simple;
	bh=eVX5RlaKuMRJwINb2OHWZ+rVrCi0vvJqyoizjkVGig4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWyDOlTrywPR4xNrYprAwId+keySXk8CN5W7KSbug2L+JMNu9lFYvew081AVCqZzbP3wBCWI/Dme8+GheoFtcnQMUgrZX+Hozo2fnsvUoyB5KUY0vaewP36LAGWANOeNDg+bi6nfxw2Bkk0aE7TQ+SimrfEGqf3m7olwlttNLoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=jeM8WgI8; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="jeM8WgI8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781806309; x=1782065509;
	bh=uOWLkakEMzznt7Fkk/Qpgrbz52wgk2m/nHfHPVsUdbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jeM8WgI80yaYE4lZGGLqiJ9MvtJDxJJEQJHVrOKXFxC/Gw8SJ7YZ8Oib+vuy5evuj
	 Pu4EpEVldjMTbsnLm/Giz2bScBaM1/oBhy567S27WBhiY4SiquY3aWeHWbAi8QhIaj
	 M22vr9t6KCuMuBpSdrUpa17yogZDRo6VmQO4DXK+SeG3P+XrdprKIOm3DymrmmAbZK
	 VvhUzSbRyIU48dDd151qa5vxwXmhcVRfVQ5TvoPqZFAB2KWL7rMBHHUPv7RIuyUfju
	 rJmNUV5k+ofOa/0wLipbkJtadxXcmULeVvk3STLCo55G/+u9vaD4QHwWglDMkAj64C
	 MjLeSElVqDqqA==
X-Pm-Submission-Id: 4gh81q5sgHz2ScqJ
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Lyude Paul <lyude@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
Date: Thu, 18 Jun 2026 21:11:40 +0300
Message-ID: <20260618181142.200117-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260618095952.3687099-4-phasta@kernel.org>
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-4-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jun 2026 11:59:52 +0200=0D
Philipp Stanner <phasta@kernel.org> wrote:=0D
=0D
> We now have a safe wrapper for the foreign function synchronize_rcu().=0D
> =0D
> Use it in poll.rs.=0D
> =0D
> Signed-off-by: Philipp Stanner <phasta@kernel.org>=0D
> ---=0D
>  rust/kernel/sync/poll.rs | 6 ++----=0D
>  1 file changed, 2 insertions(+), 4 deletions(-)=0D
> =0D
> diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs=0D
> index 0ec985d560c8..401cf4d3f35f 100644=0D
> --- a/rust/kernel/sync/poll.rs=0D
> +++ b/rust/kernel/sync/poll.rs=0D
> @@ -8,7 +8,7 @@=0D
>      bindings,=0D
>      fs::File,=0D
>      prelude::*,=0D
> -    sync::{CondVar, LockClassKey},=0D
> +    sync::{rcu::synchronize_rcu, CondVar, LockClassKey},=0D
=0D
nit: Missing vertical import. Same in the other module as well.=0D
=0D
Thanks,=0D
Onur=0D
=0D
>  };=0D
>  use core::{marker::PhantomData, ops::Deref};=0D
>  =0D
> @@ -99,8 +99,6 @@ fn drop(self: Pin<&mut Self>) {=0D
>          unsafe { bindings::__wake_up_pollfree(self.inner.wait_queue_head=
.get()) };=0D
>  =0D
>          // Wait for epoll items to be properly removed.=0D
> -        //=0D
> -        // SAFETY: Just an FFI call.=0D
> -        unsafe { bindings::synchronize_rcu() };=0D
> +        synchronize_rcu();=0D
>      }=0D
>  }=0D
> -- =0D
> 2.54.0=0D
> =0D
