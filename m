Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790143;
	b=s4dPj0wPIl02SogIkM2WNnwa0FCutpXSaCGWwb59JFRu4TfX4fTn6sj+V+q656cv26ZQ
	 xihMcNPVtgM5M3AiELWtroSLsTkch0SLtkfWDKpWJUxhDNMZ2oRhk3wMycbkxLyRJVvaf
	 VWlFBggYg4CSKlbpohQdB14U4PLnaLFA4uOyN7s5X9ab3ClW+3uHpoJEfIhivEUhz7vTO
	 6CDEcpXIseWyZ+Y+km7MgICYLX4MSIYbIfim9BWPDNh2dVeZyjcH3ud7AQbUYIjefYoMP
	 +NkEswk1JImzeRQxNvUIeAhIPBh8REwbZWUcM0DHBvU16L4gYrJnz0dqvYdI2T/3Yjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790143;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=7B4CD7AhexizOc7pFHBbwCQlAUUwVUZRIBZIAJ5e5uA=;
	b=SZjoRTinIP+Tse+d3S3LX5RAN1mGvqcqshbHCi/B0zxP3Z8JBmA83+efjuPdv3af7yyR
	 rf7L9ZI7sWAiq7X65F3RDDqtI8sXeF1o2jhNjfo/iwBdi4uSGXA60pxpuIYpe+5L/i1xU
	 rYNaOBxkbqCSzOZB9nd925AKATI/L9N2TXOz9g2gElGUDj7XwiSqKZ1ddJlzFjQED2BTu
	 /TJMpvGTMKpHYW4RWtcvNal5M/QPqAb7ezc1BFQ+wOLLZ6SDueH9oPWTeChZp+9epflIu
	 Cs7iOqBXqbS4t9Cc7oIuCCCMWgT+WwQQgdLT39zy4sYc+t5A8vz5c86DNUskZGrtrig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVxlh2Ul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2B2606A31F;
	Mon, 16 Nov 2026 00:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVxlh2Ul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE921F000C5;
	Mon, 16 Nov 2026 00:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790143;
	bh=7B4CD7AhexizOc7pFHBbwCQlAUUwVUZRIBZIAJ5e5uA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=UVxlh2UlItQLZgi45jk6Dv5h7rZ1dXedkKzaPxSQSuOvpcI0x3SaeGLZxhMX1WGTq
	 OfK6/n1BnXZpDumajPBg9fF2ESXudtGEZjWI4k2PttjlxtgNM2lYqd6yCWY1VA2uwH
	 xlvOYUGrXMBgH45CubGFmfWCRgnANhi/jw0S9RzSRb6QYps2W19kKJEUV4THA19Yxq
	 bIJZrjtAyYiPRmCBQOkuuW23HWFfrDuByb1CarHdzRT81+LXqyCUpEPQCh+fQ5uicG
	 ncK9n0Ay2GvdMt7fAf/Tex9Ew043z1PyOtTtNhscZA0MdPIRZ7LWlgleVGY8wk8chM
	 Qh/ssqAPXoSGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D92ADCE0C39; Sun, 15 Nov 2026 16:49:02 -0800 (PST)
Date: Sun, 15 Nov 2026 16:49:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <jfern@kernel.org>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH for-v7.5 13/14] rcutorture: Disable RCU priority boost
 testing on non-TREE03 scenarios
Message-ID: <423dba4b-d7fd-4d43-913a-96ebdbe3a3be@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261113005747.2977123-14-jfern@kernel.org>
 <20261115233651.GB3906606@joelbox>
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
In-Reply-To: <20261115233651.GB3906606@joelbox>

On Sun, Nov 15, 2026 at 06:36:51PM -0500, Joel Fernandes wrote:
> Hi Paul,
> 
> Can I fold in the below diff?  Sashiko found this issue in [1]: 12/14 removes
> CONFIG_RCU_BOOST=n from NOCB01 and NOCB02, so boosting is now on there too and
> rcu_torture_boost() would start, but this patch adds rcutorture.test_boost=0
> only for TREE01, TREE02, TREE08 and TREE09.  The diff sets it for the two NOCB
> scenarios as well.

Please do!

							Thanx, Paul

> [1] https://lore.kernel.org/all/sashiko-outbox-213970@kernel.org/
> 
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
> index 5130bc84c435..fe37cfc8eadb 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01.boot
> @@ -1,2 +1,3 @@
>  rcupdate.rcu_self_test=1
>  rcu_nocbs=all
> +rcutorture.test_boost=0
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
> index c212ae299b0b..3ea4f5c2a5ef 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02.boot
> @@ -1,3 +1,4 @@
>  rcupdate.rcu_self_test=1
>  rcu_nocbs=all
>  rcu_nocb_poll
> +rcutorture.test_boost=0
> 
> Thanks,
> Joel
> 
