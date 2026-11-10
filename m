Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269494;
	b=CyGlT5Qk9Ndm9sPnFivde5mQMfpL6vilDY2Z6g7fdmNzdg1tfcM1mQZH4anUqTMph535
	 VljH0Y6WWzIgzhIvDrNb+kw7PkAQICORK0wgVtRUtrB4tQ2/ZoAC0gQd8OXuvqh26TPk6
	 YqUEpaXdIf+EToLr8AkuQbPyJf+hhn0UObw3mueCJJ0PItI0SbpcLu4TimkVaAbE/RNkq
	 iK7Ea3YXVjJJtgErL5ZWHTb277H5cOhuFimCGjRaZpgN+t1NOtrzzq6PGEQ9O9BFwFwqO
	 CSaJFXRubVSPqSpY+LM4+EZy4xqUzv+WYfcMbp4ofhm9G3afe/OkXQWdsAcdjK0CCOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269494;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=wECulbhH+/PYIsAouc/0+vQU/WPYaJWlZhevaQ1pdgA=;
	b=zHCw96LkvW9I04c6F6RCYIClKNVJ6d+AfKULBs/vJLWhKjFyf8edy2IIlOkYr0OS3QEt
	 HoAOfKXJ0K4pPLFnzKryAtgeWiPgn7Aw5R4tDkRAeZNrO3lDgC7XIign3iXsoGYJc8yCW
	 6R4AZ5ezlBlv1i+aDnLoDiR0HN8QG30onfAZAVqFCMPXsjc5HTQIUWx6TyXwuBiXvnGX+
	 yspmsgaPhqSKq+k1cx5xYfW+CDL+t4KCzlg6Lsdk8xPk6PGjqAhDNW6N1aLvzV8Jelcy8
	 RztiQEikS0roiqS0xcC5JNmfsGVsHYgywn3XUq8I2sVap/rpnmuUYwx9LSZBrKFxokw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cb11HATF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A4606A332;
	Tue, 10 Nov 2026 00:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cb11HATF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A81B1F0089F;
	Tue, 10 Nov 2026 00:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269494;
	bh=wECulbhH+/PYIsAouc/0+vQU/WPYaJWlZhevaQ1pdgA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Cb11HATF1t1c/JnWLzbX6q9oYoGbypkpkFMthwSuWR+x8rBlzHhwryRtY2/TCQ/am
	 PWNp6x3m4Dawulyjak75YF9ctzy8tE5ve6hU8Z1Q2XmQt/TVE7lSteiqVyLNjaG0mc
	 3uwDwEtOPUoZW/uL2/Wp95gOWl764BeFa/DG2TgVNnJ0mbA0ERGtLPVRieIDR/V64I
	 yD8JNl2r5ZhHb4sZr4VSqWOhEJR4Ci/YHinqAVFTT+DjkmHIqbRwN3QWkil4rZ8BGv
	 mz/swpIZRaSnYXiz7cfBUTin63uzSNtQnNEk5D6WywfoIY7bXy1BGupJyiDfUmeF+N
	 qQpbh8OflLx+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BEE6CCE0C97; Mon,  9 Nov 2026 16:11:33 -0800 (PST)
Date: Mon, 9 Nov 2026 16:11:33 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/5] kasan: Avoid an unrelated RCU warning in the
 callback test
Message-ID: <c333cb25-d007-4a0c-a8d8-86187c67d747@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261109000243.3936824-1-joelagnelf@nvidia.com>
 <20261109000243.3936824-5-joelagnelf@nvidia.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109000243.3936824-5-joelagnelf@nvidia.com>

On Sun, Nov 08, 2026 at 07:02:40PM -0500, Joel Fernandes wrote:
> rcu_uaf() passes a false protection condition to
> rcu_dereference_protected(), which produces a suspicious-RCU-usage
> warning before the intended KASAN failure occurs.
> 
> The pointer refers to a fresh allocation that has not been published to
> readers. State that protection condition explicitly, leaving the intended
> tests intact.
> 
> Test:
> Built with CONFIG_KASAN_KUNIT_TEST=m
> Booted Qemu guest (8 CPUs), ran modprobe kasan_test filtered to kasan.*rcu_uaf*
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

And yes, the second argument to rcu_dereference_protected() is a boolean,
not a pointer.  Good catch!

> ---
>  mm/kasan/kasan_test_c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
> index b9e167ed5be3..4e23765d722c 100644
> --- a/mm/kasan/kasan_test_c.c
> +++ b/mm/kasan/kasan_test_c.c
> @@ -967,8 +967,9 @@ static void rcu_uaf(struct kunit *test)
>  	ptr = kmalloc_obj(struct kasan_rcu_info);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
>  
> +	/* The freshly allocated object has not been published to readers. */
>  	global_rcu_ptr = rcu_dereference_protected(
> -				(struct kasan_rcu_info __rcu *)ptr, NULL);
> +				(struct kasan_rcu_info __rcu *)ptr, true);
>  
>  	KUNIT_EXPECT_KASAN_FAIL_READ(test,
>  			call_rcu(&global_rcu_ptr->rcu, rcu_uaf_reclaim);
> -- 
> 2.54.0
> 
> 
