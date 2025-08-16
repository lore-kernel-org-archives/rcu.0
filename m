Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6E33EC;
	Sat, 16 Aug 2025 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755308573; cv=none; b=I81UgQ8zz4au5LWGbq+M92v14KQCQEk6bxzeaOddN2Z+CT8HB3wKU4CI0vG4+lAjpuVgZ30/fSpBI+r7qheIb6OCwz10fmBG93lOP4lt2w53ClxQK93DsEgCVWLP1O3Q31GBeS/qTw2lcJ/EK1qPLrOVTnIgaDXYV5VltNvHpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755308573; c=relaxed/simple;
	bh=Ocdwc5iIYZiylZvgDus/jEKaMBWDGB8Lyi4FjpVOsGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0x0mERh7Oe3dvoPYhtpLaSh/JCSVPxh073bJF7UavKbxs9tHL93+/FP0m/iz9ldt1ub6xGGdU92Hxj/JFTUaRtDnEjoyqQ3EYBhfidH+ktE83ZH7WmcHWxae555AP9xeaLJbKyUoUbk5l0TqKTB9kDBb7c3BBVbtcHN1FqPF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEizfOum; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEizfOum"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-323267bcee7so3159741a91.1;
        Fri, 15 Aug 2025 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755308572; x=1755913372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZNroSKqT8ITRNHjmLNvYVioEmty87OeCHoKEsvjikA=;
        b=JEizfOumq/rHE+WlSTm6ORZyHc57u5qaVshQJbVJTjUnlQtFVc4kcBNcArgrUsEv7H
         L/F2wrkLMHa12nDLVScfqLh5w8DK4UdBwcInorrYCNmYdn9L1CWjgjKUxcx01nwuTWhe
         XY+whevYPpVkEscJSVZqHTVwugWIaY/m4WvQZ67YHEMawp1gx6iOEz7T8CJoTOklqxBj
         3KgESrnsRqSrShsn6JoC4E8D3NRS4Nwu7FdR1jUTYkxmnAHxE52R1p43EJ9DUVYOpdwW
         X5gihoMV4H8ImgUID3GYqtRSjOFvVKaN19iDnCbZ/x9hK2xW7kIND47p8CCvWYv0nM9R
         zsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755308572; x=1755913372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZNroSKqT8ITRNHjmLNvYVioEmty87OeCHoKEsvjikA=;
        b=knpD1A3wfc4RkYeA76VqJk6bO2WGAL1I9slys1ls2XrDhB01QENH3s4uQKpwymZV+B
         aiBagp1wra07YS4CSbyH0W3iiKnyh3T2+7WYmtfJKLd45ClLBeAUg6nvPz7uv1RKmxIF
         xQOWP9zo+8634xEa0LCb+WFKs/FOrTAnkAi8cyWfS1MoIqRoM21KNrcIVnpiay4ecai7
         KYTseoap2sWnuDGe54pOj10NqLauEswQ+7eAH+rTVy0BTEgaTYNacQE05Pf2hhg/iyck
         uFPhSpwyXm0jv7Q1FeKRsga9Im7ngJ72y6cluiaRdUqoUF1ySLCDjgDeKDjJuPTiQhna
         Zhkw==
X-Forwarded-Encrypted: i=1; AJvYcCVPvWEN27itqY/xDcgvqDKM5EaU66n8ZbXIRMm/I9nFmtbBU5tX42i8lRFS7bP+lo7pjzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+fD0gzw4etTq3UfLHnuHqgfB37ir7EzkSl4XsN1w9+ofHT4ni
	FfdK/cOb269uaGpuhrMJ4p6fhC0sXDGECGZJUWdzPFa1Jc8SGxvV8dN3
X-Gm-Gg: ASbGncvfOpYNSXzBexCN+hdoISeWHgxxZrimjE44oIlFFIIXR/aSH20CIFwxkLjFQAB
	GRxkLs1mjNYzvGeLalB7KNny890bct9kGSBhwkLCTtWZQy1hqAFS2AScOI04UCjxPSkr52/tG3h
	9r+ayK0xSBTniB0Yci1xqtERQK6aw2dgDB4Pdi+kFXbP2ZFcy4qGWw4+7QWbJGqwq7PWHg98us0
	KMm1QdhgBZDWGDSpJL5AFv4AhfgtrKwapwwPc+xQQo6WPo4IYkwr0kh4jHNero5KwQKyfbJeufJ
	nIUdfMWCQObF+52md8YkQVwHkb8RJ2JJNo5TrUzPwX4+Vp/0/5YAD5LQe6PY3ZXn3+GqQJGZzBP
	YA0yNIuHOuflMwhTr5uz1umPB59RaYlCBnCPwfPIeRuwrqOTiyTUXoGWIRlPOiSxNpsCY
X-Google-Smtp-Source: AGHT+IHXyQEbP4oRrga4HvBg4NCEN5nM5vGNBl8+LWzrbhaLrGg1M9jpWJbM5XdSodeaCnmJlOLBLQ==
X-Received: by 2002:a17:90b:380a:b0:31f:b51:eef9 with SMTP id 98e67ed59e1d1-3234213e430mr6861709a91.17.1755308571561;
        Fri, 15 Aug 2025 18:42:51 -0700 (PDT)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f8329asm5466199a91.3.2025.08.15.18.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 18:42:51 -0700 (PDT)
Message-ID: <47d4f9df-4fd5-48e6-9769-58c6d6497620@gmail.com>
Date: Sat, 16 Aug 2025 10:30:24 +0900
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rcu: docs: Requirements.rst: Abide by conventions of
 kernel documentation
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>
References: <9ea6b51e-b48a-474f-b7ae-4fb6414d0aaf@paulmck-laptop>
 <20250816000007.2622326-3-paulmck@kernel.org>
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20250816000007.2622326-3-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 17:00:07 -0700, Paul E. McKenney wrote:
> From: Akira Yokosawa <akiyks@gmail.com>
> 
> Here is a list of conventions applied here:
> 
> - Don't mark up function names, to be taken care of by the automarkup
>   extension.  Just say func().
> - Instead of ".. code-block:: none", just say "::".
> - Mark inline literals by a pair of ``xxxx``.  Don't use rust doc's
>   dialect of `yyyy`.
> - Instead of emphasizing headings by **strong emphasis**, use sub-level
>   title adornments, in this case "^^^^^^^^^^" and make them proper
>   sub-sections under "Hotplug CPU".
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>

Missing S-o-b of Paul?

Joel, I'd rather like to have your ack here.  Could you?

        Thanks, Akira

> ---
>  .../RCU/Design/Requirements/Requirements.rst  | 52 +++++++++----------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 
[...]

